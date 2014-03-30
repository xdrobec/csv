<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class User extends CI_Controller {

    public function __construct() {
        parent::__construct();

        $this->load->model('user_model');
        $this->load->view('header');
    }

    public function index() {
        if (($this->session->userdata('user_name') != "")) {
            $this->profil($this->session->userdata('user_id'));
        } else {
            redirect(base_url());
        }
    }

    public function login_form() {
        $this->load->view('user/login_form');
        $this->load->view('footer');
    }

    public function login() {
        $login = $this->input->post('login');
        $password = md5($this->input->post('password'));

        $result = $this->user_model->login($login, $password);
        if ($result) { //vytvorenie session v user_model
            echo "ok";
//            $this->session->set_userdata($result);
//            $this->user_model->create_logs($result["user_id"]);
//            redirect(base_url() . $this->input->post('url'));
        }
        else
            echo "bad";
//            $this->index();
    }

    public function thank() {
        $this->load->view('user/thank_view.php');
        $this->load->view('footer');
    }

    public function register_form() {
        //$this->load->helper('form');
        $data['letter_options'] = array('en' => 'EN', 'sk' => 'SK', '--' => '--');
        $this->load->model('country_model');
        if ($this->session->userdata('lang') == "english")
            $countries = $this->country_model->getEnglishStates();
        else
            $countries = $this->country_model->getSlovakStates();

        $select = '<select id="state" name="state">';
        foreach ($countries as $country) {
            $select .= "<option value=" . $country->short . ">" . $country->state . "</option>";
        }
        $select .= '</select>';
        $data['select'] = $select;
        $this->load->view("user/registration_view", $data);
        $this->load->view('footer', $data);
    }

    
    //sluzi na zobrazenie profilu pouzivatela
    public function profil($id = 1) {
        
        if ( ($id == NULL))
            $id = $this->session->userdata('user_id');
        $id = (int) $id; 
        
        $profil = $this->user_model->get_user($id);

        if ($profil == NULL)
            show_error("Chyba.", 404, "Zadaný používateľ sa v databáze nenachádza.");

        $data['user_data'] = $profil;
        $this->load->view("user/my_profil", $data);
        $this->load->view('footer', $data);
    }

    
    public function all() {

        if (($this->session->userdata('role') != "admin") && ($this->session->userdata('role') != "user")) {
            show_error('Marha neskusaj nas hackovat! Sme na teba pripraveny!');
        }
        $data['users'] = $this->user_model->get_all_users();


        $this->load->view('user/all_view', $data);
        $this->load->view('footer');
    }

    public function delete($id) {

        if ($this->session->userdata('role') != "admin")
            show_error('Marha neskusaj nas hackovat! Sme na teba pripraveny!');

        $this->user_model->delete_user($id);

        $this->all();
    }

    public function edit() {

        if ($this->session->userdata('user_name') == "")
            show_error('Marha neskusaj nas hackovat!');

        $id = $this->input->post('user_id');

        $data = array();

        $data['name'] = $this->input->post('name');
        $data['surname'] = $this->input->post('surname');
        $data['news_lang'] = $this->input->post('news_lang');
        $data['email'] = $this->input->post('email');
        $data['state'] = $this->input->post('state');

        if (($this->input->post('type') == "reg") && ($this->input->post('password') != ""))
            $data['password'] = md5($this->input->post('password'));

        if ($this->session->userdata('role') == "admin") {
            $data['role'] = $this->input->post('role');
        }

        $this->user_model->edit_user($id, $data);

        redirect(base_url() . 'user/profil/' . $id);
    }

    public function ldap_login_form() {
        $this->load->view("user/ldap_login_view");
        $this->load->view('footer');
    }

    public function ldap_login() {
        $login = $this->input->post('login');
        $password = $this->input->post('pass');

        $host = 'ldap.stuba.sk';
        $cl = ldap_connect($host);  // pripojenie k ldapu

        if ($cl) { // uspesne pripojene k ldapu
            $l = ldap_bind($cl, "uid=" . $login . ",ou=People,dc=stuba,dc=sk", $password);

            if ($l) { //uspesne prihlaseny
                $sr = ldap_search($cl, "ou=People,dc=stuba,dc=sk", "uid=" . $login);
                $info = ldap_get_entries($cl, $sr);

                $email = $info[0]['mail'][1];
                $first = $info[0]['givenname'][0];
                $last = $info[0]['sn'][0];
                $lang = 'sk';

                $was = $this->user_model->find_user($email);
                if ($was) {
                    $sessionsy = array(
                        'user_id' => $was['user_id'],
                        'user_name' => $was['login'],
                        'user_email' => $was['email'],
                        'name' => $was['name'],
                        'surname' => $was['surname'],
                        'role' => $was['role'],
                        'type' => 'ldap',
                        'logged_in' => TRUE,
                    );
                } else {
                    $vytvor = array(
                        'login' => $email,
                        'name' => $first,
                        'surname' => $last,
                        'email' => $email,
                        'type' => "ldap",
                        'role' => "user",
                        'news_lang' => $lang,
                        'state' => $lang,
                    );
                    $id = $this->user_model->add_user_ldap($vytvor);
                    $sessionsy = array(
                        'user_id' => $id,
                        'user_name' => $email,
                        'user_email' => $email,
                        'name' => $first,
                        'surname' => $last,
                        'role' => "user",
                        'type' => "ldap",
                        'logged_in' => TRUE,
                    );
                }
                $this->session->set_userdata($sessionsy);
                $this->user_model->create_logs($sessionsy["user_id"]);
                redirect(base_url());
            } else { // neuspesne prihlaseny
                redirect(base_url());
            }
            ldap_close($cl);
        } else { //nepripojene k ldapu
            redirect(base_url());
        }


        $this->load->view('footer');
    }

    public function google_init() {
        //require_once '/../libraries/openid.php';
        $this->load->library('LightOpenID');
        $openid = new LightOpenID(base_url());

        $openid->identity = 'https://www.google.com/accounts/o8/id';
        $openid->required = array(
            'namePerson/first',
            'namePerson/last',
            'contact/email',
            'pref/language',
        );
        $openid->returnUrl = base_url() . 'user/google_login';
        redirect($openid->authUrl());
    }

    public function google_login() {
        //require_once '/../libraries/openid.php';
        $this->load->library('LightOpenID');
        $openid = new LightOpenID(base_url());

        if ($openid->mode) {
            if ($openid->mode == 'cancel') {
                echo "User has canceled authentication !";
            } elseif ($openid->validate()) {
                $data2 = $openid->getAttributes();
                $email = $data2['contact/email'];
                $first = $data2['namePerson/first'];
                $last = $data2['namePerson/last'];
                $lang = $data2['pref/language'];
                if (($lang != "sk") || ($lang != "en")) {
                    $lang = "en";
                }
                $was = $this->user_model->find_user($email);
                if ($was) {
                    $sessionsy = array(
                        'user_id' => $was['user_id'],
                        'user_name' => $was['login'],
                        'user_email' => $was['email'],
                        'role' => $was['role'],
                        'name' => $first,
                        'type' => "google",
                        'surname' => $last,
                        'logged_in' => TRUE,
                    );
                } else {
                    $vytvor = array(
                        'login' => $email,
                        'name' => $first,
                        'surname' => $last,
                        'email' => $email,
                        'type' => "google",
                        'role' => "user",
                        'news_lang' => $lang,
                        'state' => $lang,
                            //'password' => $this->input->post('password')
                    );
                    $id = $this->user_model->add_user_google($vytvor);
                    $sessionsy = array(
                        'user_id' => $id,
                        'user_name' => $email,
                        'user_email' => $email,
                        'name' => $first,
                        'type' => "google",
                        'surname' => $last,
                        'role' => "user",
                        'logged_in' => TRUE,
                    );
                }
                $this->session->set_userdata($sessionsy);
                $this->user_model->create_logs($sessionsy["user_id"]);
                redirect(base_url());
            } else {
                redirect(base_url());
            }
        } else {
            redirect(base_url());
        }


        $this->load->view('footer');
    }

    public function registration() {
        $pass = $this->user_model->add_user();
        $name = $this->input->post('user_name');
        $surname = $this->input->post('user_surname');
        $login = $this->input->post('login');
        $email = $this->input->post('email_address');

        //posli heslo na zadany mail
        $this->load->library('email');
        $config_m['protocol'] = 'mail';
        $config_m['mailtype'] = 'html';
        $config_m['charset'] = 'utf-8';
        $config_m['wordwrap'] = TRUE;
        $this->email->initialize($config_m);

        $this->email->from('cois_system@stuba.sk', 'COIS reg.');
        $this->email->to($email);

        $this->email->subject('IIA registration');
        $this->email->message("$name $surname<br>" . $this->lang->line('kecy_reg') . "<br>login: $login<br>password: $pass<br><br>COIS team.<br>#DONOTREPLY");

        if (!$this->email->send()) {
            echo 'bad.';
        } else {
            echo'ok.';
        }

        $this->thank();
    }

    public function logout() {
        $newdata = array(
            'user_id' => '',
            'user_name' => '',
            'user_email' => '',
            'role' => '',
            'logged_in' => FALSE,
        );
        $this->session->unset_userdata($newdata);
        //$this->session->sess_destroy();
        redirect(base_url());
    }

}

?>

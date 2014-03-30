<?php if (!defined('BASEPATH'))  exit('No direct script access allowed');

class User_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    function login($login, $password) {
        
        $this->db->where("user__username", $login);
        $this->db->where("user__passwordhash", $password);

        $query = $this->db->get("user");
        
        if ($query->num_rows() > 0) {
            foreach ($query->result() as $rows) {
//                //add all data to session
                $newdata = array(
                    'user_id' => $rows->user__id);
//                    'user_name' => $rows->login,
//                    'user_email' => $rows->email,
//                    'name' => $rows->name,
//                    'surname' => $rows->surname,
//                    'role' => $rows->role,
//                    'type' => $rows->type,
//                    'logged_in' => TRUE,
//                );
            }

            return $newdata;
        }
        return false;
    }

    public function create_logs($id) {
        //vytvorenie logov
        $ipecka = $this->input->ip_address();
        if (strlen($ipecka) < 6)
            $ipecka = "147.175.106.44";
        $this->load->helper('geo_location');
        $geo_data = get_geolocation($ipecka);


        $insertLog = array(
            'id_user' => $id,
            'ip_address' => $ipecka,
            'state' => $geo_data['country_name'],
        );
        $this->db->insert("logs", $insertLog);
    }

    public function get_user_logs($id) {
        //vytvorenie logov
        $query = $this->db->query("SELECT * FROM logs WHERE id_user=" . $id . " ORDER by id_log DESC");
        return $query->result();
    }

    public function add_user() {
        $pass = substr(md5(time()), 1, 7);
        $data = array(
            'login' => $this->input->post('login'),
            'name' => $this->input->post('user_name'),
            'surname' => $this->input->post('user_surname'),
            //'password' => $this->input->post('password'),
            'email' => $this->input->post('email_address'),
            'type' => $this->input->post('typ'),
            'role' => $this->input->post('rola'),
            'news_lang' => $this->input->post('news_lang'),
            'state' => $this->input->post('state'),
            'password' => md5($pass)
        );
        $this->db->insert('users', $data);
        return $pass;
    }

    public function get_user($user_id) {
        
        $this->db->where("user__id", $user_id);
        $query = $this->db->get("user");
        
        if ($query->num_rows() > 0) {
            foreach ($query->result() as $rows) {
                $newdata = array(
                    'id' => $rows->user__id,
                    'name' => $rows->user__name,
                    'surname' => $rows->user__surname,
                    'degree' => $rows->user__degree,
                    'email' => $rows->user__email,
                    'username' => $rows->user__username,
                    'password' => $rows->user__passwordhash,
                    'webaddress' => $rows->user__webaddress,
                    'phone' => $rows->user__phone,
                    'active' => $rows->user__isactive,
                    'role' => $rows->user__id_role,
                );
            }

            return $newdata;
        }
        return false;
    }

    public function find_user($login) {
        $this->db->where("login", $login); //
        $this->db->where("type", "google");
        //$this->db->or_where("type", "ldap");

        $query = $this->db->query("SELECT * FROM users WHERE login='$login' AND (type='google' OR type='ldap')");

        if ($query->num_rows() > 0) {
            foreach ($query->result() as $rows) {
                //add all data to session
                $newdata = array(
                    'user_id' => $rows->user_id,
                    'login' => $rows->login,
                    'password' => $rows->password,
                    'name' => $rows->name,
                    'surname' => $rows->surname,
                    'role' => $rows->role,
                    'type' => $rows->type,
                    'state' => $rows->state,
                    'news_lang' => $rows->news_lang,
                    'email' => $rows->email,
                    'logged_in' => TRUE,
                );
            }

            return $newdata;
        }
        return false;
    }

    public function add_user_ldap($data) {

        $this->db->insert('users', $data);
        return $this->db->insert_id();
    }

    public function add_user_google($data) {

        $this->db->insert('users', $data);
        return $this->db->insert_id();
    }

    public function edit_user($id, $data) {
        // $data - array('nazov_stlpca' => 'hodnota', 'nazov_stlpca' => 'hodnota', 'nazov_stlpca' => 'hodnota' ... );
        $query = $this->db->update('users', $data, array('user_id' => $id));
    }

    public function get_all_users() {

//        $this->db->select('user_id, login, name, surname,');
//        $query = $this->db->get('users');

        $query = $this->db->query("SELECT * FROM (SELECT users.user_id, users.login, users.name, users.surname, users.type, logs.time AS time, logs.ip_address AS ip_address FROM logs LEFT JOIN users ON users.user_id = logs.id_user ORDER BY logs.time DESC) as spolocna GROUP BY spolocna.user_id ORDER BY spolocna.time DESC");
        return $query->result();
    }

    public function delete_user($id) {

        $this->db->where('user_id', $id);
        $this->db->delete('users');
    }

    public function get_all_users_newsletter() {

        $this->db->select('user_id, email, name, surname, news_lang');
        $this->db->where('news_lang', 'sk');
        $this->db->or_where('news_lang', 'en');
        $query = $this->db->get('users');
        return $query->result();
    }

    public function getUserCountries() {
        $this->db->select('state, count(state) as count');
        $this->db->from('users');
        $this->db->group_by('state');
        $this->db->order_by("count", "DESC");
        $query = $this->db->get();
        return $query->result();
    }

    public function getLoginCountries() {
        $this->db->select('state, count(state) as count');
        $this->db->from('logs');
        $this->db->group_by('state');
        $this->db->order_by("count", "DESC");
        $query = $this->db->get();
        return $query->result();
    }

}

?>

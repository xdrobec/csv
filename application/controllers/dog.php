<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Dog extends CI_Controller {

    /**
     * Index Page for this controller.
     *
     * Maps to the following URL
     * 		http://example.com/index.php/welcome
     * 	- or -  
     * 		http://example.com/index.php/welcome/index
     * 	- or -
     * Since this controller is set as the default controller in 
     * config/routes.php, it's displayed at http://example.com/
     *
     * So any other public methods not prefixed with an underscore will
     * map to /index.php/welcome/<method_name>
     * @see http://codeigniter.com/user_guide/general/urls.html
     */
    
    public function __construct() {
        parent::__construct();

        $this->load->model('Dog_model', 'dog');
        $this->load->model('Photo_model', 'photo');
        $this->load->view('header');
    }
    
    public function index() {
        
    }
    
    public function show($id, $name){
        $id = (int) $id;
        if ($id < 1)
            show_error("Neexistujúci pes", 404, "Tento pes neexistuje");

        if (($dog = $this->dog->getDog($id)) == NULL)
            show_error("Neexistujúci pes", 404, "Tento pes neexistuje");
        
        $data['dog'] = $dog[0];
        
        $photos = $this->photo->findAll($id);
        $data['photos'] = $photos;
        
        $this->load->view('dog/dogdetail', $data);
        $this->load->view('footer');
        
    }

}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */
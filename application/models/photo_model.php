<?php

class Photo_model extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }

    function findAll($dogid) {
//      $this->db->select('title, content, date');
        $query = $this->db->get_where('dog_photo', array('dog_photo__id_dog' => $dogid));
        return $query->result();
    }


}

?>
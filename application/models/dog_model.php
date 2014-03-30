<?php

class Dog_model extends CI_Model {

    function __construct() {
        // Call the Model constructor
        parent::__construct();
    }

    function getDog($id) {
//      $this->db->select('title, content, date');
        $query = $this->db->get_where('dog', array('dog__id' => $id));
        return $query->result();
    }


}

?>
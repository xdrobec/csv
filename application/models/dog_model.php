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
    
    function getAllDogs() {
        $query = $this->db->query("SELECT `dog`.`dog__id`,`dog`.`dog__name`,`dog`.`dog__gender`,`dog`.`dog__breed`,`user`.`user__id`,`user`.`user__name`,`user`.`user__surname` FROM `dog`,`user`,`user_dog_relation` WHERE `dog`.`dog__id`= `user_dog_relation`.`user_dog_relation__id_dog` and `user_dog_relation`.`user_dog_relation__id_user` = `user`.`user__id` and (`user_dog_relation`.`user_dog_relation__state` = 'majitel')");
        return $query->result();
    }


}

?>
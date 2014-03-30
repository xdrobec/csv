<?php

echo "<table><tr><th>Meno psa</th><th>Pohlavie</th><th>Plemeno</th><th>Majiteľ</th></tr>";
foreach($dogs as $dog){
    echo "<tr>";
        echo "<td>".anchor("dog/show/".$dog->dog__id."/".preg_replace('/\s+/','',$dog->dog__name), $dog->dog__name)."</td>";
        echo "<td>".$dog->dog__gender."</td>";
        echo "<td>".$dog->dog__breed."</td>";
        echo "<td>".anchor("user/profil/".$dog->user__id, $dog->user__name." ".$dog->user__surname)."</td>";
    echo "</tr>";
}
echo "</table>"

?>

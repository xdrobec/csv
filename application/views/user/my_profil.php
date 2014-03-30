<?php

echo form_open('user/change_profile');
echo form_label('Meno:', 'name');
echo form_input('name', $user_data->name);
echo form_label('Priezvisko:', 'surname');
echo form_input('surname', $user_data->surname);
echo form_label('Dátum narodenia:', 'birthdate');
echo form_input('birthdate', $user_data->degree);
echo form_label('Titul:', 'degree');
echo form_input('degree', $user_data->degree);

if ($user_data->active == "ano") {
    echo form_label('Som členom klubu', 'club');
    echo form_radio('club', 'ano', TRUE);
    echo form_label('Žiadam o členstvo v KCHČSV', 'username');
    echo form_radio('club', 'nie', FALSE);
} else {
    echo form_label('Som členom klubu', 'club');
    echo form_radio('club', 'ano', FALSE);
    echo form_label('Žiadam o členstvo v KCHČSV', 'username');
    echo form_radio('club', 'nie', TRUE);
}
echo form_label('Používateľské meno:', 'username');
echo form_input('username', $user_data->username);
echo form_label('Heslo', 'password');
echo form_password('password', $user_data->password);

echo form_label('Ulica', 'street');
echo form_input('street', $user_data->address->street);
echo form_label('Číslo domu:', 'housenumber');
echo form_input('housenumber', $user_data->address->housenumber);
echo form_label('Mesto:', 'city');
echo form_input('city', $user_data->address->city);
echo form_label('PSČ:', 'postcode');
echo form_input('postcode', $user_data->address->postcode);
echo form_label('Krajina:', 'country');
echo form_input('country', $user_data->address->city);


var_dump($user_data);
echo "<br><br>";
echo $user_data->id;
echo "<br><br>";
echo $user_data->address->street;

echo "<br><br>";
echo $user_data->role->realname;

echo form_label('Týmto potvrdzujem, že mnou uvedené údaje sú pravdivé.', 'user_submit');
echo form_submit('user_submit', 'Odoslať');
form_close();
?>

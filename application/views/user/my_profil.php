<STYLE>
    .leftform{
        display: block;
        float: left; 
        width: 200px;
    } 
    .rightform{
        display: block;

    }

</STYLE>
<?php
echo form_open('user/change_profile');
echo form_fieldset('Základné údaje');
echo "<div class='leftform'>";
echo form_label('Meno:', 'name');
echo form_input('name', $user_data->name);
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
echo "</div>";
echo "<div class='rightform'>";
echo form_label('Priezvisko:', 'surname');
echo form_input('surname', $user_data->surname);
echo form_label('Dátum narodenia:', 'birthdate');
echo form_input('birthdate', $user_data->degree);
//echo form_fieldset('Členstvo v klube KCHČSV');
//echo form_fieldset_close();
echo "</div>";
echo form_fieldset_close();

echo form_fieldset('Prihlasovacie údaje');
echo "<div class='leftform'>";
echo form_label('Používateľské meno:', 'username');
echo form_input('username', $user_data->username);
echo "</div>";
echo "<div class='rightform'>";
echo form_label('Heslo:', 'password');
echo form_password('password', $user_data->password);
echo "</div>";
echo form_fieldset_close();

echo form_fieldset('Adresa');
echo "<div class='leftform'>";
echo form_label('Ulica:', 'street');
echo form_input('street', $user_data->address->street);
echo form_label('Mesto:', 'city');
echo form_input('city', $user_data->address->city);
echo form_label('Krajina:', 'country');
echo form_input('country', $user_data->address->country->country_name);


echo "</div>";


echo "<div class='rightform'>";
echo form_label('Číslo domu:', 'housenumber');
echo form_input('housenumber', $user_data->address->housenumber);
echo form_label('PSČ:', 'postcode');
echo form_input('postcode', $user_data->address->postcode);


echo "</div>";



echo form_fieldset_close();
echo form_fieldset('Kontaktné údaje');
echo form_label('Email:', 'email');
echo form_input('email', $user_data->email);
echo form_label('Webová stránka:', 'www');
echo form_input('www', $user_data->webaddress);
echo form_label('Telefón:', 'tel');
echo form_input('tel', $user_data->phone);
echo form_fieldset_close();
echo form_label('Týmto potvrdzujem, že mnou uvedené údaje sú pravdivé.', 'user_submit');
echo form_submit('user_submit', 'Odoslať');
form_close();
?>

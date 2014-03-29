<!DOCTYPE html>
<html>
    <head>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type"/>

        <link rel="stylesheet" href="<?php echo base_url() . 'style/main.css' ?>"/>
        <link rel="stylesheet" href="<?php echo base_url() . 'style/form.css' ?>"/>
        <link rel="stylesheet" href="<?php echo base_url() . 'style/header.css' ?>"/>
        <link rel="stylesheet" href="<?php echo base_url() . 'style/footer.css' ?>"/>

        <script type="text/javascript" src="<?php echo base_url() . 'javascript/jquery-2.0.3.min.js' ?>"></script>
        <script type="text/javascript" src="<?php echo base_url() . 'javascript/main.dev.js' ?>"></script>

    </head>

    <body>
        <div id="mHeader">
            <div id="mStripe"></div>
            <div class="inner">
                <div class="container">
                    <a id="mLogo" href="<?php echo base_url(); ?>"></a>
                </div>
            </div>
            <nav id="hrzNav">
                <div class="container">
                    <ul>
                        <li>
                            <?php echo anchor('user/login', "Prihlásenie"); ?>
                        </li>
                        <li>
                            <?php echo anchor('user/register', "Registrovať sa"); ?>
                        </li>
                        <li>
                            <?php echo anchor('page/contact', "Kontakt"); ?>
                        </li>
                    </ul>
                    <div class="clear"></div>
                </div>
            </nav>
            <div class="clear"></div>
        </div>
        <!-- END OF HEADER -->

        <div class="container" id="mContainer">

            <div id="vertNav-placeholder"></div>
            <nav id="vertNav">
                <ul>
                    <li><a href="#">Posledné pridané</a></li>
                    <li><a href="#">Výsledky klubových výstav</a></li>
                    <li><a href="#">Výsledky SVP</a></li>
                    <li><a href="#">Výsledky zvodu a bonitácií</a></li>
                    <li><a href="#">Vyhľadávanie jedincov</a></li>
                    <li><a href="#">Chovateľské stanice</a></li>
                    <li><a href="#">Štatistiky</a></li>
                    <li><a href="#">Chovateľský plán</a></li>
                    <li><a href="#">Plemenná kniha</a></li>
                </ul>
            </nav>

            <div id="content">
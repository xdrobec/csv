<span id="dog-index">
    <div class="left">
        <h1><?php echo $dog->dog__name ?></h1>
        <div class="detail-blck left">
            <table>
                <tbody>
                    <tr>
                        <th>Farba</th>
                        <td><?php echo $dog->dog__color ?></td>
                    </tr>
                    <tr>
                        <th>Pohlavie</th>
                        <td><?php echo ($dog->dog__gender == 'F')? 'suka' : 'pes' ?></td>
                    </tr>
                    <tr>
                        <th>Narodenie</th>
                        <td><?php echo date('d.m.Y' ,strtotime($dog->dog__birthday)); ?></td>
                    </tr>
                    <tr>
                        <th>Plemeno</th>
                        <td><?php echo $dog->dog__breed; ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="detail-blck right">
            <table>
                <tbody>
                    <tr>
                        <th>Staré registračné číslo</th>
                        <td><?php echo $dog->dog__old_regnumber ?></td>
                    </tr>
                    <tr>
                        <th>Nové registračné číslo</th>
                        <td><?php echo $dog->dog__new_regnumber ?></td>
                    </tr>
                    <tr>
                        <th>Tetovanie</th>
                        <td><?php echo empty($dog->dog__tatoo )? 'nie' : $dog->dog__tatoo; ?></td>
                    </tr>
                    <tr>
                        <th>Čip</th>
                        <td><?php echo $dog->dog__chip; ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="clear"></div>
        <h3 style="margin: 10px 0">Prebieha debug :D</h3>
    </div>
    <div class="rightOvf">
        <div id="galleryOpened"><!-- Container for opened image -->
            <div class="container"></div>
        </div>
        <div class="gallery">
            <?php 
                if( !empty( $photos ) ){
                              
                    $prim_img = array_shift($photos);
                    //if( $this->findFile( $prim_img->dog_photo__fileurl ) != NULL  ){
                        echo '<a class="thumb" id="prim-img"';
                        echo 'title="' . $dog->dog__name . '" ';
                        echo 'href="'.base_url().DOG_PHOTO_FOLDER.$prim_img->dog_photo__id_dog.'/'.$prim_img->dog_photo__fileurl.'" target="_blank"';
                        echo '>';
                            echo '<span class="img-pos-helper"></span>';
                            echo '<img alt="' . $dog->dog__name . '" ';
                            echo 'src="'.base_url().DOG_PHOTO_FOLDER.$prim_img->dog_photo__id_dog.'/'.$prim_img->dog_photo__fileurl.'" ';
                            echo (isset( $prim_img->dog_photo__width ) && intval($prim_img->dog_photo__width) != 0 )? ('data-width="'. $prim_img->dog_photo__width . '" ') : ' ';
                            echo (isset( $prim_img->dog_photo__height ) && intval($prim_img->dog_photo__height) != 0)? ('data-height="'. $prim_img->dog_photo__height . '" ') : ' ';
                            echo '"/>';
                        echo '</a>';
                    //}
                    echo '<div class="thumbs">';
                    foreach ( $photos as $image ){
                        //if( $this->findFile( $image->dog_photo__fileurl ) != NULL  ){
                            echo '<a class="thumb"';
                            echo 'title="' . $dog->dog__name . '" ';
                            echo 'href="' . base_url().DOG_PHOTO_FOLDER.$image->dog_photo__id_dog.'/'.$image->dog_photo__fileurl . '" target="_blank"';
                            echo '>';
                                echo '<span class="img-pos-helper"></span>';
                                echo '<img alt="' . $dog->dog__name . '" ';
                                echo 'src="'.base_url().DOG_PHOTO_FOLDER.$image->dog_photo__id_dog.'/'.$image->dog_photo__fileurl.'" ';
                                echo (isset( $image->dog_photo__width ) && intval($image->dog_photo__width) != 0 )? ('data-width="'. $image->dog_photo__width . '" ') : ' ';
                                echo (isset( $image->dog_photo__height ) && intval($image->dog_photo__height) != 0)? ('data-height="'. $image->dog_photo__height . '" ') : ' ';
                                echo '"/>';
                            echo '</a>';
                        //}
                    }
                    echo '</div>';
                }
            ?>
        </div>
    </div>
    
</span>
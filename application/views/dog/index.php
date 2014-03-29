<span id="dog-index">
    
    <div class="left">
        <h1><?php echo $data->dog->name ?></h1>
        <div class="detail-blck left">
            <table>
                <tbody>
                    <tr>
                        <th>Farba</th>
                        <td><?php echo $data->dog->color ?></td>
                    </tr>
                    <tr>
                        <th>Pohlavie</th>
                        <td><?php echo ($data->dog->name == 'F')? 'suka' : 'pes' ?></td>
                    </tr>
                    <tr>
                        <th>Narodenie</th>
                        <td><?php echo date('d.m.Y' ,strtotime($data->dog->birthday)); ?></td>
                    </tr>
                    <tr>
                        <th>Plemeno</th>
                        <td><?php echo $data->dog->breed; ?></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="detail-blck right">
            <table>
                <tbody>
                    <tr>
                        <th>Staré registračné číslo</th>
                        <td><?php echo $data->dog->old_regnumber ?></td>
                    </tr>
                    <tr>
                        <th>Nové registračné číslo</th>
                        <td><?php echo $data->dog->new_regnumber ?></td>
                    </tr>
                    <tr>
                        <th>Tetovanie</th>
                        <td><?php echo empty($data->dog->tatoo )? 'nie' : $data->dog->tatoo; ?></td>
                    </tr>
                    <tr>
                        <th>Čip</th>
                        <td><?php echo $data->dog->chip; ?></td>
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
                if( !empty( $data->photos ) ){
                    $prim_img = array_shift( $data->photos );
                    if( $this->findFile( $prim_img->fileurl ) != NULL  ){
                        echo '<a class="thumb" id="prim-img"';
                        echo 'title="' . $data->dog->name . '" ';
                        echo 'href="' . $prim_img->fileurl . '" target="_blank"';
                        echo '>';
                            echo '<span class="img-pos-helper"></span>';
                            echo '<img alt="' . $data->dog->name . '" ';
                            echo 'src="'. $prim_img->fileurl . '" ';
                            echo (isset( $prim_img->width ) && intval($prim_img->width) != 0 )? ('data-width="'. $prim_img->width . '" ') : ' ';
                            echo (isset( $prim_img->height ) && intval($prim_img->height) != 0)? ('data-height="'. $prim_img->height . '" ') : ' ';
                            echo '"/>';
                        echo '</a>';
                    }
                    echo '<div class="thumbs">';
                    foreach ( $data->photos as $image ){
                        if( $this->findFile( $image->fileurl ) != NULL  ){
                            echo '<a class="thumb"';
                            echo 'title="' . $data->dog->name . '" ';
                            echo 'href="' . $image->fileurl . '" target="_blank"';
                            echo '>';
                                echo '<span class="img-pos-helper"></span>';
                                echo '<img alt="' . $data->dog->name . '" ';
                                echo 'src="'. $image->fileurl . '" ';
                                echo (isset( $image->width ) && intval($image->width) != 0 )? ('data-width="'. $image->width . '" ') : ' ';
                                echo (isset( $image->height ) && intval($image->height) != 0)? ('data-height="'. $image->height . '" ') : ' ';
                                echo '"/>';
                            echo '</a>';
                        }
                    }
                    echo '</div>';
                }
            ?>
        </div>
    </div>
    
</span>
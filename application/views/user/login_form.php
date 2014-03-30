<div class="centerOuter">
    <div class="centerInner">
        <?php echo form_open("user/login"); ?>   
        
        <label for="login" class="requiredField">Meno: </label>
        <input type="text" id="login" name="login">

        <label for="password" class="requiredField">Heslo: </label>
        <input type="password" id="password" name="password" >

        <input type="submit" id="submit" value="Submit">

        <?php echo form_close(); ?>
    </div>
</div>
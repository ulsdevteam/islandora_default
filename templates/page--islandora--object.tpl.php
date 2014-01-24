<div id="page-secondary">
    <div class="banner">
      <img class="seal" src="<?php print base_path() . path_to_theme(); ?>/images/pittseal_1.gif" alt="UPitt seal" />
        <?php print theme('links__system_secondary_menu', array('links' => $secondary_menu, 'attributes' => array('class' => array('banner')),)); ?>
      <img class="logo" src="<?php print base_path() . path_to_theme(); ?>/images/drl_logo.png" alt="ULS logo" />
      <!-- print banner region -->
        <?php print render($page['banner']); ?>
    </div><!-- /end banner -->

   	<div id="nav">
			<?php print theme('links__system_main_menu', array('links' => $main_menu, 'attributes' => array('class' => array('primary-nav')),)); ?>
      <div id="search">
        <?php print render($page['search']); ?>
      </div><!-- /end search -->
    </div><!-- /end nav -->

    <?php print $messages; ?>

<div id="two-col-left-main">

  <div>

    <?php print render($page['content']); ?>




    <div style="float:left">
      <?php print render($page['islandora_object_sidebar']); ?>
    </div>

    </div>

 <div id="footer">
  	<div id="footer-col1">
  		<?php print render($page['footer-col1']); ?>
    </div><!-- /end footer column 1 -->
    <div id="footer-col2">
  		<?php print render($page['footer-col2']); ?>
    </div><!-- /end footer column 2 -->
	</div><!-- /end footer -->
</div><!-- /end two-col-left-main -->

</div><!-- /end page-secondary -->
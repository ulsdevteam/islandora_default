<div id="page-secondary">
<div class="banner"> <img class="seal" src="<?php print base_path() . path_to_theme(); ?>/images/pittseal_1.gif" alt="UPitt seal" /> <?php print theme('links__system_secondary_menu', array('links' => $secondary_menu, 'attributes' => array('class' => array('banner')),)); ?> <img class="logo" src="<?php print base_path() . path_to_theme(); ?>/images/drl_logo.png" alt="ULS logo" /> 
  <!-- print banner region --> 
  <?php print render($page['banner']); ?> </div>
<!-- /end banner -->

<div id="nav"> <?php print theme('links__system_main_menu', array('links' => $main_menu, 'attributes' => array('class' => array('primary-nav')),)); ?>
  <div id="search"> <?php print render($page['search']); ?> </div>
  <!-- /end search --> 
</div>
<!-- /end nav --> 

<?php print $messages; ?>
<div id="two-col-right-main">
  <?php //print $breadcrumb; ?>
  <!--<p class="breadcrumb">HOME > <$PAGE_VARIABLE></p>-->
  
  <?php //if ($tabs): ?>
  <div class="tabs"><?php //print render($tabs); ?></div>
  <?php //endif; ?>
  <?php //if ($action_links): ?>
  <ul class="action-links">
    <?php //print render($action_links); ?>
  </ul>
  <?php //endif; ?>
  <div id="col1">
    <div class="widget"> <?php print render($page['sidebar']); ?> </div>
    <!-- /end widget --> 
  </div>
  <!-- /end col1 -->
  
  <div id="col2"> <?php print render($title_prefix); ?>
    <?php if ($title): ?>
    <h1><?php print $title; ?></h1>
    <?php endif; ?>
    <?php print render($title_suffix); ?> <?php print render($page['content']); ?> </div>
  <!-- /end col2 -->
  <div id="footer">
    <div id="footer-col1"> <?php print render($page['footer-col1']); ?> </div>
    <!-- /end footer column 1 -->
    <div id="footer-col2"> <?php print render($page['footer-col2']); ?> </div>
    <!-- /end footer column 2 --> 
  </div>
  <!-- /end footer --> 
</div>
<!-- /end page-secondary -->
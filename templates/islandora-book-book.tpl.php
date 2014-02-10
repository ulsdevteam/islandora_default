<?php
/**
 * @file
 * Template file to style output.
 */
?>
<?php if (isset($metadata_link)): ?>
  <?php print $metadata_link; ?>
<?php endif; ?>
<?php if (isset($viewer)): ?>
  <div id="book-viewer">
    <?php print $viewer; ?>
  </div>
<?php endif; ?>
<!-- @todo Add table of metadata values -->

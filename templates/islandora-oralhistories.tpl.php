<?php

/**
 * @file
 * This is the template file for the object page for oralhistories
 *
 * Available variables:
 * - $islandora_object: The Islandora object rendered in this template file
 * - $islandora_dublin_core: The DC datastream object
 * - $dc_array: The DC datastream object values as a sanitized array. This
 *   includes label, value and class name.
 * - $islandora_object_label: The sanitized object label.
 * - $parent_collections: An array containing parent collection(s) info.
 *   Includes collection object, label, url and rendered link.
 *
 * @see template_preprocess_islandora_oralhistories()
 * @see theme_islandora_oralhistories()
 */
?>

<div class="islandora-oralhistories-object islandora" vocab="http://schema.org/" prefix="dcterms: http://purl.org/dc/terms/" typeof="VideoObject">
  <div class="islandora-oralhistories-content-wrapper  clearfix">
    <?php if ($islandora_content['viewer']): ?>
      <div class="islandora-oralhistories-content">
        <?php print $islandora_content['viewer']; ?>
      </div>
    <?php endif; ?>
  </div>

<h2>How do I play the video in full screen mode with subtitles?</h2>
  <ul>
    <li>Click on the “full screen” button <img src="/sites/all/themes/islandora_default/images/full-screen.png" width="32" height="29" alt=""> in the lower right-hand corner of the video player. </li>
    <li>Then, click the “CC” button. <img src="/sites/all/themes/islandora_default/images/cc.png" width="33" height="23" alt=""></li>
    <li>Next,  click within the narrow bar <strong>below</strong> “captions off.”  <img src="/sites/all/themes/islandora_default/images/captions-off-white-bar.png" width="100" height="31" alt=""> </li>
    <li>The subtitles will appear on the screen with the video.</li>
  </ul>
<p><em>Please note: We are working to improve functionality of the video player. </em></p>

  <div class="islandora-oralhistories-metadata">
    <?php print $description; ?>
    <?php if ($parent_collections): ?>
      <div>
        <h2><?php print t('In collections'); ?></h2>
        <ul>
          <?php foreach ($parent_collections as $collection): ?>
        <li><?php print l($collection->label, "islandora/search_collection/{$collection->id}"); ?></li>
          <?php endforeach; ?>
        </ul>
      </div>
    <?php endif; ?>
    <?php print $metadata; ?>
  </div>
</div>



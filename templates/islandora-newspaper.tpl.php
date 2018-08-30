<?php

/**
 * @file
 * This is the template file for the object page for newspaper
 *
 * Available variables:
 * - $islandora_content: A rendered vertical tabbed newspapper issue browser.
 * - $parent_collections: An array containing parent collection IslandoraFedoraObject(s).
 * - $description: Rendered metadata descripton for the object.
 * - $search_box: newspaper-specific search box html and javascript block.
 * - $metadata: Rendered metadata display for the binary object.
 *
 * @see template_preprocess_islandora_newspaper()
 */
?>
<div class="islandora-newspaper-object islandora">
<?php if ($search_box): ?>
  <div id="newspaper_search_box">
    <?php print $search_box; ?>
  </div>
<?php endif; ?>
  <div class="islandora-newspaper-content-wrapper clearfix">
    <?php if ($islandora_content_copy): ?>
      <div class="islandora-newspaper-content">
        <?php print $islandora_content_copy; ?>
      </div>
    <?php endif; ?>
  </div>
  <div class="islandora-newspaper-metadata">
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

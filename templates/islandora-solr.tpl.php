<?php
/**
 * @file
 * Islandora solr search primary results template file.
 *
 * Variables available:
 * - $results: Primary profile results array
 *
 * @see template_preprocess_islandora_solr()
 */

?>
<?php if (empty($results)): ?>

<p class="no-results"><?php print t('Sorry, but your search returned no results.'); ?></p>
<?php else: ?>

<?php $row_result = 0; ?>
<?php foreach($results as $key => $result): ?>
<!-- Search result -->
<div class="islandora-solr-search-result clear-block <?php print $row_result % 2 == 0 ? 'odd' : 'even'; ?>"> 
  <!-- Thumbnail -->
  <!--<div class="collection-wrapper"> <!-- provides the border around EACH result -->
    <div class="search-result-wrapper">
      <div class="search-result-img-wrapper"> <?php print $result['thumbnail']; ?> 
      </div><!-- /end search-result-img-wrapper --> 
    </div><!-- /end search-result-wrapper --> 
    <!-- Metadata -->
    <ul>
      <?php foreach($result['solr_doc'] as $key => $value): ?>
      <li> <?php print $value['value']; ?> </li>
      <?php endforeach; ?>
      <?php $row_result++; ?>
    </ul>
  <!--</div><!-- /end collection-wrapper --> 
</div>
<?php endforeach; ?>

<?php endif; ?>

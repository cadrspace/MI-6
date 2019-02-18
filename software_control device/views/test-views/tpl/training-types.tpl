<h3>Список тренировок</h3>
<p>Начните тренировку или создайте новую!</p>
<table class="table">
<!--
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col">Handle</th>
    </tr>
  </thead>
 -->
  <tbody>
  <?php
	$row_number = 1;
	if(isset($data) && is_array($data) && isset($data['tpl']['params'])) {
		if(isset($data['tpl']['params']['training_types_list'])) {
			foreach($data['tpl']['params']['training_types_list'] as $id=>$item) {
				echo '<tr><th scope="row">'.$row_number.'</th>';
				echo '<td>'.$item['title'].'</td>
						<td><a href="training-process/'.$id.'" class="btn btn-primary btn-lg active" role="button" aria-pressed="true">start</td>
						<td><a href="training-edition/'.$id.'" class="btn btn-success btn-lg active" role="button" aria-pressed="true">edit</td>
						<td><a href="training-remove/'.$id.'" class="btn btn-danger btn-lg active" role="button" aria-pressed="true">del</td>
					';
				echo '</tr>';
				$row_number++;
			}
		}
	}
	
  ?>
  
  </tbody>
</table>
<?php
echo '<a href="'.$dirpath.'training-create" class="btn btn-info btn-lg" tabindex="-1" role="button" aria-disabled="true">Создать</a>';
?>
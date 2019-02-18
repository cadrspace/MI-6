<?php

if(isset($data['tpl']['params']) && !empty($data['tpl']['params'])) {
	$tr_info = $data['tpl']['params']['training_type'];
	//$tr_ittr = $data['tpl']['params']['ittr'];
	//$tr_result_list = $data['tpl']['params']['results_list'];
?>
<h3>Результаты тренировки «<?php echo $tr_info['title']?>»</h3>

<p>Тренировка удачно завершена!</p>

<?php
	$row_number = 1;
	if(isset($data['tpl']['params']['training_results_list'])) {
	echo '<p>Дата '.$data['tpl']['params']['date'].'</p>';
	echo '<table class="table"><tbody>
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">Мишени</th>
				<th scope="col">Попадания</th>
				<th scope="col">Всего</th>
				<th scope="col">%</th>
			</tr>
		</thead>
	';
		
	foreach($data['tpl']['params']['training_results_list'] as $id=>$item) {
	
			$targets = '';
			foreach($item['targets_list'] as $t_id=>$t_item) {
				$targets .= '<span class="badge badge-pill badge-'.n_to_class($t_item['current'], $t_item['sets_amount']).'">'.$t_item['current'].'/'.$t_item['sets_amount'].'</span>';
			}
			echo '<tr class="table-'.s_to_class($item['status']).'">
					<th scope="row">'.$row_number.'</th>
						<td>'.$targets.'</td>					
						<td>'.$item['done'].'</td>
						<td>'.$item['amount'].'</td>
						<td>'.(100*floatval($item['done'])/floatval($item['amount'])).'</td>
					</tr>
				';
			$row_number++;
		}
	}
	
	echo '</tbody></table>';
	
	
}
echo '<a href="'.$dirpath.'training-process/'.$data['tpl']['params']['training_id'].'" class="btn btn-warning btn-lg" tabindex="-1" role="button" aria-disabled="true">Начать тренировку</a>';
echo '<br>';
echo '<a href="'.$dirpath.'training-types" class="btn btn-info btn-lg" tabindex="-1" role="button" aria-disabled="true">Список тренировок</a>';
echo '<a href="'.$dirpath.'all-training-results" class="btn btn-info btn-lg" tabindex="-1" role="button" aria-disabled="true">Все результаты</a>';
?>

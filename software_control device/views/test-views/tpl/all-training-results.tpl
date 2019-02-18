

<h3>Все резульаты тренировок</h3>



<?php
/*$data['tpl']['params']['all_training_results'] = $dataset['all_training_results'];
				$data['tpl']['params']['training_types_list'] = $dataset['training_types_list'];
				$data['tpl']['params']['training_results_list'] = $dataset['training_results_list'];*/


$row_number = 1;
	if(isset($data['tpl']['params']['training_results_list'])) {
	echo '<table class="table"><tbody>
		<thead>
			<tr>
				<th scope="col">#</th>
				<th scope="col">Дата</th>
				<th scope="col">Тренировка</th>
				<th scope="col">Результат</th>
				<th scope="col"></th>
			</tr>
		</thead>
	';
		
	foreach($data['tpl']['params']['all_training_results'] as $id=>$item) {
	
			$targets = '';
			
			$tt_item = $data['tpl']['params']['training_types_list'][$item['training_type_id']];

			echo '<tr class="table">
					<th scope="row">'.$row_number.'</th>
						<td>'.$item['date'].' '.$item['time'].'</td>					
						<td>'.$tt_item['title'].'</td>
						<td>'.$item['result'].'</td>
						<td><a href="training-result/1" class="btn btn-success btn-lg active" role="button" aria-pressed="true">view</td>
					</tr>
				';
			$row_number++;
		}
	}
	
	echo '</tbody></table>';
	
	

//echo '<a href="'.$dirpath.'training-process/'.$data['tpl']['params']['training_id'].'" class="btn btn-warning btn-lg" tabindex="-1" role="button" aria-disabled="true">Начать тренировку</a>';
//echo '<br>';
echo '<a href="'.$dirpath.'training-types" class="btn btn-info btn-lg" tabindex="-1" role="button" aria-disabled="true">Список тренировок</a>';
//echo '<a href="'.$dirpath.'all-training-results" class="btn btn-info btn-lg" tabindex="-1" role="button" aria-disabled="true">Все результаты</a>';
?>

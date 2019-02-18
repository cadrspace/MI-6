<?php
$dirpath = '/mishen/';

function url_decode() {
	global $dirpath;
	
	$str = substr( '/'.$_SERVER['REQUEST_URI'],strlen($dirpath)+1);
	$apos = strpos($str, '?');
	if($apos) {
		$str = substr( $str, 0, $apos);
	}
	return array_diff(explode('/',$str), array('')) ;
	}

function s_to_class($val) {
	
	$in_arr = [
		'active',
		'noactive',
		'normal',
		'selected',
	];
	$out_arr = [
		'primary',
		'disabled',
		'default',
		'success'
	];
	return str_replace($in_arr ,$out_arr , $val);

}

function n_to_class($current, $amount) {

	$in_arr = [
		'light',
		'dark',
		'success',
		'warning',
	];
	
	$out = $in_arr[0];
	
	if($amount > 0) {
		$s =  $current/$amount;
		
		if($current == 2)
			$out = $in_arr[1];
		if($current == 0)
			$out = $in_arr[3];
	}
	return $out;
}

	$data = [
		'url'=>'',
		'tpl'=>[
			'name'=>'training-types',
			'params'=>[],
		],
	];
	
	$dataset = [
		'training_types_list'=>[
			'1'=>['title'=>'Стрельба по очереди', 'info'=>'adsfasdashduashdhasidhu adushhasd'],
			'2'=>['title'=>'Стрельба по случайной мишени','info'=>'adsfasdashduashdhasidhu adushhasd'],
		],
		'all_training_results'=>[
			[
				'date'=>'01.01.2002',
				'time'=>'13:03:33',
				'training_type_id'=>'1',
				'tr_id'=>'0', // не определен, подставить то единственное что есть
				'result'=>'2/5',
			],
			[
				'date'=>'03.01.2022',
				'time'=>'11:03:33',
				'training_type_id'=>'1',
				'tr_id'=>'0', // не определен, подставить то единственное что есть
				'result'=>'3/3',
			],
			[
				'date'=>'01.01.2012',
				'time'=>'15:03:33',
				'training_type_id'=>'2',
				'tr_id'=>'0', // не определен, подставить то единственное что есть
				'result'=>'1/1',
			],
			[
				'date'=>'01.01.2002',
				'time'=>'14:03:33',
				'training_type_id'=>'2',
				'tr_id'=>'0', // не определен, подставить то единственное что есть
				'result'=>'0/5',
			],
			[
				'date'=>'01.01.2012',
				'time'=>'11:05:23',
				'training_type_id'=>'1',
				'tr_id'=>'0', // не определен, подставить то единственное что есть
				'result'=>'1/2',
			],
			[
				'date'=>'21.11.2012',
				'time'=>'10:00:00',
				'training_type_id'=>'2',
				'tr_id'=>'0',
				'result'=>'0/0', // не определен, подставить то единственное что есть
			],
		],
		'training_results_list'=>[
			'1'=>[
				'status'=>'selected',
				'done'=>3,
				'amount'=>4,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>0,
						'sets_amount'=>'1',
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>0,
						'sets_amount'=>'1',
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>1,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>1,
					],
				],
			],
			'2'=>[
				'status'=>'selected',
				'done'=>1,
				'amount'=>10,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>0,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>0,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>1,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>1,
					],
				],
			],
			'3'=>[
				'status'=>'selected',
				'done'=>0,
				'amount'=>10,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>0,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>0,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>1,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>1,
					],
				],
			],
			'4'=>[
				'status'=>'selected',
				'done'=>'',
				'amount'=>4,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>0,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>0,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>1,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>1,
					],
				],
			],
		],
		'training_process'=>[
			'1'=>[
				'status'=>'selected',
				'done'=>4,
				'amount'=>4,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>1,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>1,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>2,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>0,
					],
				],
			],
			'2'=>[
				'status'=>'active',
				'done'=>4,
				'amount'=>4,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>1,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>1,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>2,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>0,
					],
				],
			],
			'3'=>[
				'status'=>'normal',
				'done'=>4,
				'amount'=>4,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>1,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>1,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>2,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>0,
					],
				],
			],
			'4'=>[
				'status'=>'normal',
				'done'=>4,
				'amount'=>4,
				'targets_list'=>[
					'1'=>[
						'name'=>'target_1',
						'current'=>1,
						'sets_amount'=>1,
					],
					'2'=>[
						'name'=>'target_2',
						'current'=>1,
						'sets_amount'=>1,
					],
					'3'=>[
						'name'=>'target_3',
						'current'=>2,
						'sets_amount'=>2,
					],
					'4'=>[
						'name'=>'target_4',
						'current'=>0,
						'sets_amount'=>0,
					],
				],
			],
		],
	];
	
	
	$data['url']= url_decode();
	
	$data['tpl']['name'] = $data['url'][0];
	if(!isset($data['url'][0]))$data['url'][0]='';
	if(!isset($data['url'][1]))$data['url'][1]='';
	
	switch($data['url'][0]) {
		case 'programm':
			switch($data['url'][1]) {
				case 'init_programm':
					$str = [
						'prog_data'=>[
						
							'prg_id' => 939834,
							'status' => 200,
						]
					];
					header('Content-Type: application/json');
					echo json_encode($str);
					exit();
					break;
					
				case 'title_programm':
					$str = [
						'prog_data'=>[
						
							'prg_id' => 939834,
							'status' => 200,
						]
					];
					header('Content-Type: application/json');
					echo json_encode($str);
					exit();
					break;
				case 'step_programm':
					$str = [
						'prog_data'=>[
						
							'prg_id' => 939834,
							'status' => 200,
						]
					];
					header('Content-Type: application/json');
					echo json_encode($str);
					exit();
					break;
				case 'step_programm_edit':
					$str = [
						'prog_data'=>[
						
							'prg_id' => 939834,
							'status' => 200,
						]
					];
					header('Content-Type: application/json');
					echo json_encode($str);
					exit();
					break;
			}
			break;
		case 'training-types':
			$data['tpl']['params']['training_types_list'] = $dataset['training_types_list'];
			$data['tpl']['name'] = $data['url'][0];
			break;
		case 'training-process':
			if(isset($data['url'][1]) && isset($dataset['training_types_list'][$data['url'][1]]) ) {
				$data['tpl']['params']['training_id'] = $data['url'][1];
				$data['tpl']['params']['training_type'] = $dataset['training_types_list'][$data['url'][1]];
				$data['tpl']['params']['training_results_list'] = $dataset['training_process'];
				$data['tpl']['name'] = $data['url'][0];
			}
			break;
		case 'training-create':	
			$data['tpl']['name'] = $data['url'][0];
			break;
		case 'training-result':
			if(isset($data['url'][1]) && isset($dataset['training_results_list'][$data['url'][1]]) ) {
				$data['tpl']['params']['training_id'] = $data['url'][1];
				$data['tpl']['params']['date'] = '12.12.2020';
				$data['tpl']['params']['training_type'] = $dataset['training_types_list'][$data['url'][1]];
				$data['tpl']['params']['training_results_list'] = $dataset['training_results_list'];
				$data['tpl']['name'] = $data['url'][0];
			}
			break;
		case 'all-training-results':
		
			if(isset($data['url'][1]) && isset($dataset['all_training_results']) ) {

				$data['tpl']['params']['all_training_results'] = $dataset['all_training_results'];
				$data['tpl']['params']['training_types_list'] = $dataset['training_types_list'];
				$data['tpl']['params']['training_results_list'] = $dataset['training_results_list'];
				$data['tpl']['name'] = $data['url'][0];
			}

			break;
		case 'training-edition':
			$data['tpl']['name'] = $data['url'][0];
			break;
		case 'training-results-edition':
			$data['tpl']['name'] = $data['url'][0];
			break;
		default:
			$data['tpl']['name'] = 'unknown';
			header('Location: http://localhost'. $dirpath . 'training-types');
			exit();
			break;
	}
?>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
		<link href="css/open-iconic/font/css/open-iconic-bootstrap.min.css" rel="stylesheet">
		<script src="jquery/jquery-3.1.1.min.js"></script>
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<div class="col">
				<?php
					$tmpl = 'tpl/'.$data['tpl']['name'].'.tpl';
					if( file_exists( $tmpl )) {
						include_once $tmpl;
					} else {
						header("HTTP/1.0 404 Not Found");
						include_once 'tpl/page404.tpl';
					}
				?>
				</div>
			</div>
		</div>

		<script src="bootstrap/js/popper.min.js"></script>
		<script src="bootstrap/js/bootstrap.min.js"></script>
		<script src="js/script.js"></script>
	</body>
</html>
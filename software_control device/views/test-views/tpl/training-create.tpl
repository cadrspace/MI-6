<div id="col">

	<div id="trainingTitleBlock" class="row align-items-center justify-content-around">
		<div class="col-12 col-sm-10 col-md-10">
			<h1 data-value="t_title"></h1>
			<p data-value="t_desc"></p>
		</div>
		<div class="col-12 col-sm-2 col-md-2">
			<button type="button btn-block" class="btn btn-primary" data-btn="t_edit"><span class="oi oi-ellipses" title="Редактировать title" aria-hidden="true"></span></button>
		</div>
	</div>
	
	<div id="trainingListBlock"></div>
	
	<div id="trainingToolbarBlock" class="row row align-items-center justify-content-around">
		<div class="col-2">
			<button type="button" class="btn btn-primary btn-lg btn-block" data-btn="t_next_cadr"><span class="oi oi-plus" title="icon plus" aria-hidden="true"></span></button>
		<!--
			<button type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#training_step_form"><span class="oi oi-plus" title="icon plus" aria-hidden="true"></span></button>
		-->
		</div>
		<!-- <button type="button" class="btn btn-primary btn-lg" id="test_btn">#test</button>	-->
	</div>

	<div class="modal fade" id="training_title_form">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Training</h4>
				</div>
				<div class="modal-body">
					<input id="t_title_input" name="t_title" type="text" class="form-control" placeholder="Тренировка" value="">
					<textarea id="t_desc_input" name="t_desc" class="form-control" rows="3" cols="55" placeholder="Описание тренировки"></textarea>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-btn="t_cancel" data-dismiss="modal">Отмена</button>
					<button type="button" class="btn btn-primary" data-btn="t_save">Сохранить</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="training_step_form">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-data">
					<input type="hidden" name="cadr_idx" value="">
					<input type="hidden" name="form_idx" value="">
				</div>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Title</h4>
				</div>
				<div class="modal-body">
					<div class="container-fluid">
						<div class="col-10">
							<div class="form-check">
								 <input class="form-check-input" type="checkbox" name="rnd_sel_chbx" aria-label="random selection">
								 <label class="form-check-label" for="rnd_sel_chbx_input">Случайный выбор</label>
							</div>
							
							<input type="text" name="farm_val" class="form-control" placeholder="" value="">

							<div class="radio">
								<label>
									<input type="radio" name="stop_factor" value="stop_factor_time">
									 <label class="form-check-label" for="stop_factor_time_input">Время
								</label>
							</div>
							
							<div class="radio">
								<label>
									<input type="radio" name="stop_factor" value="stop_factor_quant">
									<label class="form-check-label" for="stop_factor_quant_input">Количество попаданий
								</label>
							</div>
						</div>
						<div class="col-2 ml-auto">
							<button type="button" data-btn="next_form" class="btn btn-primary btn-lg"><span class="oi oi-chevron-right" title="Ещё форму" aria-hidden="true"></span></button>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-btn="f_cancel" data-dismiss="modal">Отмена</button>
					<button type="button" class="btn btn-primary" data-btn="f_save">Сохранить</button>
				</div>
			</div>
		</div>
	</div>

<script>

	$(function() {
		/* ajax request object */
		var request;
		
		/* local data model for all the code */
		var prog_data = {
			prg_id: 0,
			status: 0,
		};
		
		/* local data model for title block */
		var title_data = {
			t_title: '',
			t_desc: '',
		};
		
		var title_data_templ = {
			t_title: 'Новая тренировка',
			t_desc: 'Описание новой тренировки',
		};

		/* локальная модель данных для формы 		*/
		var form_data_templ = {
			stop_factor:'',
			rnd_sel_chbx: true,
			farm_val: '',
			cadr_idx:'',
			form_idx:'',
		};


		
		function ItemList() {

			this.list_data = [];

			this.log = function() {
				console.log('cadr_amount:',this.cadrAmount());
				console.log(this.list_data);
			}
			
			this.cadrAmount = function() {
				return this.list_data.length;
			}
			this.formAmount = function(cadr_idx) {
				if(this.cadrAmount() > 0 && cadr_idx < this.cadrAmount() )
					return this.list_data[cadr_idx].length;
			}
			this.checkForm = function(cadr_idx, form_idx) {
				var lc = this.formAmount(cadr_idx);
				console.log('checkForm',cadr_idx, form_idx, lc);
				return (lc != undefined && form_idx < lc);
			}
			
			this.getLastCadrIdx = function() {
				var idx = this.cadrAmount();
				if(idx > 0) {
					return --idx;
				}
			}
			
			this.getLastFormIdx = function(cadr_idx) {
				
				var idx = this.formAmount(cadr_idx);
				if(idx > 0) {
					return --idx;
				}
			}
			
			/*
				low level adding new cadr - current version add after last cadr item
				migth redesined in future - cadr can be created in any place
			*/
			this.addCadr = function() {
				this.list_data.push([]);
				return this.getLastCadrIdx();
			};
			
			/*
				low level adding new form into cadr - current version add after last form item
				migth redesined in future - form can be created in any place
			*/
			this.addForm = function(cadr_idx, _form_data) {
				if(this.cadrAmount() > 0 && cadr_idx < this.cadrAmount() ){
					this.list_data[cadr_idx].push(_form_data);
					return true;
				}
			};
			
			// create new cadr at last position and place firest tne form into it
			this.createNewCadr = function(_form={}) {
				var cadr_idx = this.addCadr();
				return this.addForm(cadr_idx, _form);
			}
			
			// create new form at last position of the cadr
			this.createNewForm = function(cadr_idx, _form) {
				return this.addForm(cadr_idx, _form);
			}
			
			// not tested
			this.delForm = function(cadr_idx, form_idx) {
				if(	this.checkForm(cadr_idx, form_idx) ) {
					this.list_data[cadr_idx].splice(form_idx,1);
					if(0 == this.formAmount(cadr_idx) ) {
						this.delCadr(cadr_idx);
					}
				}
			}
			// not tested
			this.delCadr = function(cadr_idx) {
				if(	cadr_idx < this.cadrAmount() ) {
					this.list_data.splice(cadr_idx, 1);
				}
			}
			
			/*
				get current form value
			*/
			this.getForm = function(cadr_idx, form_idx) {
				console.log('getForm:',cadr_idx, form_idx);
				if(	this.checkForm(cadr_idx, form_idx) ) {
					console.log('gooddata: ',this.list_data[cadr_idx][form_idx]);
					return this.list_data[cadr_idx][form_idx];
				}
			}
			/*
				set current form value
			*/
			this.setForm = function(cadr_idx, form_idx, _form) {
				if(	this.checkForm(cadr_idx, form_idx) ) {
					this.list_data[cadr_idx][form_idx] = _form;
					return true;
				}
			}
		};
		
		function ItemManager() {

			this.item_list = new ItemList();
			this.par_obj = $('#trainingListBlock');
			
			var self = this;
			
			this.testconfig = function() {

				var test_data1 = {
					test_name: 'a1',
					test_value: 'b2',
				};
				var test_data2 = {
					test_name: 'c3',
					test_value: 'd4',
				};
				var test_data3 = {
					test_name: 'e5',
					test_value: 'f6',
				};
				var test_data4 = {
					test_name: 'g7',
					test_value: 'h8',
				};
				var test_data5 = {
					test_name: 'i7',
					test_value: 'j8',
				};
			

				this.item_list.createNewCadr(test_data1);
				this.item_list.createNewForm(this.item_list.getLastCadrIdx(), test_data3);
				this.item_list.createNewForm(this.item_list.getLastCadrIdx(), test_data4);
				this.item_list.createNewCadr(test_data2);
				this.item_list.createNewForm(this.item_list.getLastCadrIdx(), test_data5);

			}
			this.nextForm = function(cadr_idx,_form) {
				return this.item_list.createNewForm(cadr_idx,_form);
			}
			
			this.createNextCadr=function(_form) {
				this.item_list.createNewCadr(_form);
			}

			this.getForm = function(c_idx, f_idx) {
				return this.item_list.getForm(c_idx, f_idx);
			}
			
			this.setForm = function(c_idx, f_idx, _form) {
				return this.item_list.setForm(c_idx, f_idx, _form);
			}
			
			this.render = function(sel_elem_f) {
				
				var c_obj, f_obj, par_ul;
				var self = this;
				this.par_obj = $('#trainingListBlock');
				this.par_obj.empty();
				this.par_obj.html('<ul id="cadr_list"></ul>');

				par_ul = this.par_obj.find('#cadr_list');

				for(var c_idx = 0; c_idx < this.item_list.cadrAmount(); c_idx++) {
					par_ul.append('<li data-cadr="'+c_idx+'"><span><a href="#">C#'+c_idx+'</a></span><ul></ul></li>');
					f_obj = par_ul.find('[data-cadr="'+c_idx+'"] ul');
					for(var f_idx = 0; f_idx < this.item_list.formAmount(c_idx); f_idx++) {
						f_obj.append('<li data-form="'+f_idx+'"><a href="#">F#'+f_idx+'</a></li>');
					}
				}
				this.par_obj.find('[data-form] a').on('click',function(a){
					sel_elem_f(a);
				});
			}
			
			this.edit = function() {
				
			}

		}
		
		function showFormByBtn(a) {
			var l_obj = $(a.currentTarget).parent();
			var f_idx =  l_obj.attr('data-form');
			var c_idx =  l_obj.parent().parent().attr('data-cadr');
		}
		
		/*
			grab form and fill local model object
			par_tag_obj - parent tag object
			local_data - data model object
		*/
		function getFormVal(par_tag_obj, _local_data) {
			
			var key = 0;
			var key_tag = null;
			var out_data = [];

			for(key in _local_data) {
				key_tag = par_tag_obj.find('[name="'+key+'"]');
				if(key_tag != undefined) {
					out_data[key] = key_tag.val();
				}
			}
			return out_data;
		}
		
		
		function getFormChkBox(par_tag_obj, input_name) {
			return par_tag_obj.find('[name="'+input_name+'"]').is(':checked');
		}
		
		function getFormRadio(par_tag_obj, input_name) {
			return par_tag_obj.find('[name="'+input_name+'"]').filter(':checked').val();
		}
		
		function setFormChkBox(par_tag_obj, input_name, arr) {
			par_tag_obj.find('[name="'+input_name+'"]').prop( "checked", arr[input_name] );
		}
		
		function setFormRadio(par_tag_obj, input_name, arr) {
			par_tag_obj.find('[name="'+input_name+'"]').filter('[value='+input_name+']').prop('checked', true);
		}
		

		function setFormVal(par_tag_obj, _local_data) {

			var key = 0;
			var key_tag = null;
			
			for(key in _local_data) {
				key_tag = par_tag_obj.find('[name="'+key+'"]');
				key_tag.val('');
				if(key_tag != undefined) {
					key_tag.val(_local_data[key]);
				}
			}
		}
		
		function setBlockVal( par_tag_obj, _local_data) {

			var key = 0;
			var key_tag = null;
			
			for(key in _local_data) {
				key_tag = par_tag_obj.find('[data-value="'+key+'"]');
				if(key_tag != undefined) {
					key_tag.html(_local_data[key]);
				}
			}
		}
		
		function getBlockVal(par_tag_obj, _local_data) {
			
			var key = 0;
			var key_tag = null;
			var out_data = [];
			
			for(key in _local_data) {
				key_tag = par_tag_obj.find('[data-value="'+key+'"]');
				if(key_tag != undefined) {
					out_data[key] = key_tag.html();
				}
			}
			return out_data;
		}
		
		function resetForm( par_tag_obj, _local_data) {
			var key = 0;
			var key_tag = null;
			
			for(key in _local_data) {
				key_tag = par_tag_obj.find('[name="'+key+'"]');
				if(key_tag != undefined) {
					key_tag.val('');
				}
			}
		}
		/*
			ajax request
			sub url - sub url
			data - data for server
			sf - callback func that executes at responce
		*/
		function sendServ( sub_url = '', data = '', sf=null) {
			var request;
			var url = '/mishen/programm/' + sub_url + '/';

			if (request) {
				request.abort();
			}
			
			data['prog_data'] = prog_data;
			request = $.ajax({
				url: url,
				dataType: 'json',
				type: 'get',
				data: data
			});

			request.done(function (response, textStatus, jqXHR){
				var d = JSON.parse(jqXHR.responseText);
				if(sf != null)
					sf(d);
			});

		};

		var im = new ItemManager();
		//im.testconfig();

		/*
			Title block rendering
			fill title html by title_data values
		*/
		function setTitleBlock(_title_data) {
			setBlockVal($('#trainingTitleBlock'), _title_data);
		}

		function configTitleForm(_title_data) {
			
			setTitleBlock(_title_data);
			var modal = $('#training_title_form');
			$('#trainingTitleBlock').find('[data-btn="t_edit"]').on('click',function(event){
				
				setFormVal(modal, title_data);
				modal.modal('show');
			});

			modal.find('[data-btn="t_save"]').on('click',function(event){
				
				title_data = getFormVal(modal, title_data);
				sendServ('title_programm',title_data,
					function(d) {
						if(d.prog_data.status == 200) {
							setTitleBlock(title_data);
							modal.modal('hide');
						}
					}
				);
			});
		}
		
		function configStepForm() {
		
			var modal = $('#training_step_form');
			modal.find('[data-btn="f_save"]').on('click',function(event){

				var modal = $('#training_step_form');
				
				var form_data = getFormVal(modal, form_data_templ);
				form_data['rnd_sel_chbx'] = getFormChkBox(modal, 'rnd_sel_chbx');
				form_data['stop_factor'] = getFormRadio(modal, 'stop_factor');
				
				if(form_data.form_idx != undefined && form_data.form_idx!='') {
					sendServ('step_programm_edit',form_data,
						function(d){
							if(d.status!=undefined && d.status != 200) {
								console.log('wrong status!');
							} else {
								im.setForm(form_data.cadr_idx, form_data.form_idx, form_data);
							}
						}
					)
				}
				else {
					sendServ('step_programm',form_data,
						function(d){
							if(d.status!=undefined && d.status != 200) {
								console.log('wrong status!');
							} else {
								im.createNextCadr(form_data);
								im.render(function(a) {
									var cont = $(a.target).parent();
									var f_idx = cont.attr('data-form');
									var c_idx = cont.parent().parent().attr('data-cadr');
									var f = im.getForm(c_idx, f_idx);
									f.cadr_idx = c_idx;
									f.form_idx = f_idx;
									setFormVal(modal,f);
									setFormChkBox(modal, 'rnd_sel_chbx',f);
									setFormRadio(modal, 'stop_factor',f);
									modal.modal('show');
								});
							}
						}
					);
				}
				resetForm(modal,form_data_templ);
				modal.modal('hide');
			});
			
			
			modal.find('[data-btn="next_form"]').on('click',function(event){
				modal.find('[data-btn="f_save"]').trigger( "click" );
			});
			
			$('#trainingToolbarBlock').find('[data-btn="t_next_cadr"]').on('click',function(){

				var modal = $('#training_step_form');
				modal.modal('show');
			});
		}

		
		/*
			load initialisation
			- geting programm id
			- events definition
		*/
		function init_training() {

			sendServ('init_programm','',function(d){prog_data.prg_id = d.prog_data.prg_id});

			configTitleForm(title_data_templ);
			
			configStepForm();
		
		}
		
		init_training();
		/*
		$('#col').append('<button type="button" class="btn btn-primary btn-lg" id="test_btn">#test</button>');
		$('#test_btn').on('click',function(a){
			console.log(im.item_list);
		});
		*/
	});
</script>
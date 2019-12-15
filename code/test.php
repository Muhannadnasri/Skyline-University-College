<?php defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
require APPPATH . '/libraries/REST_Controller.php';

class test extends REST_Controller {

    function __construct()
    {
        parent::__construct();
       	$this->load->model('email_sending');
		$this->load->model('push');
	}

	function dbConnect($database)
	{
		//$dsn 	= 'sqlsrv://mobileapps:Appsskyline1990@192.168.167.207/'.$database.'?db_debug=false';
		$dsn 	= 'sqlsrv://'.DB_USERNAME.':'.DB_PASSWPRD.'@'.DB_HOSTNAME.'/'.$database.'?db_debug=false';
		$db 	=	$this->load->database($dsn,TRUE);
		return  $db;
	}
	
	/*Guest module : START */


	
	
	public function getLocations_post()
	{
		
			$data	=	$this->master_model->getRecords('master_location',array('master_location.is_active'=>1),'id,name,address1,phone1,email,latitude,longitude',array('sequence'=>'ASC'));
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getLocations"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Locations not found.";
				$response["command"]="getLocations"; 
				$this->set_response($response, 200);
			}
	
	}
	
	public function getProgramsByCategory_post()
	{
		$category_id =	$this->post('category_id');

		if($category_id!='' )
		{
			$data	=	$this->master_model->getRecords('master_program',array('master_program.is_active'=>1,'program_cat_id'=>$category_id),'id,name,description',array('sequence'=>'ASC'));
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getProgramsByCategory"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Programs not found.";
				$response["command"]="getProgramsByCategory"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getProgramsByCategory"; 
			$this->set_response($response, 200);
		}
	}

	public function getProgramTabs_post()
	{
		$program_id =	$this->post('program_id');

		if($program_id!='')
		{
			$data	=	$this->master_model->getRecords('master_program_tabs',array('master_program_tabs.is_active'=>1,'program_id'=>$program_id),'id,name,content_type,content',array('sequence'=>'ASC'));
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getProgramTabs"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Program tabs not found.";
				$response["command"]="getProgramTabs"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getProgramTabs"; 
			$this->set_response($response, 200);
		}
	}

	public function getPageInfo_post()
	{
		$name =	$this->post('name');

		if($name!='')
		{
			$data	=	$this->master_model->getRecords('page_info',array('page_info.is_active'=>1,'name'=>$name),'id,title,type,page_content');
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getPageInfo"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Page info not found.";
				$response["command"]="getPageInfo"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getPageInfo"; 
			$this->set_response($response, 200);
		}
	}

	public function getAptitudeProgramAndNationality_post()
	{
		

		
			$data['programs']=$this->dbConnect('CDB_Academic_Pro')->query("select DegreeType_Id,DegreeType_Desc from degreeType_master where IsActive = 1 ORDER BY DegreeType_Desc ASC")->result_array();
			$data['nationality']=$this->dbConnect('CDB')->query("select NationalityID,NationalityName from tblNationality where IsActive = 1")->result_array();

			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getAptitudeProgramAndNationality"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Program and Nationality data not found.";
				$response["command"]="getAptitudeProgramAndNationality"; 
				$this->set_response($response, 200);
			}
		
	}

	public function apptitudeForm_post()
    {
		$fname		=	$this->post('fname');
		$mname		=	$this->post('mname');
		$lname		=	$this->post('lname');
		$mobile_no	=	$this->post('mobile_no');
		$tel_no		=	$this->post('tel_no');
		$email		=	$this->post('email');
		$dob		=	$this->post('dob');
		$nationality_id		=	$this->post('nationality_id');
		$city		=	$this->post('city');
		$address 	=	$this->post('address');
		$program_id	=	$this->post('program_id');
		$stud_prof	=	$this->post('stud_prof');
		$school_university	=	$this->post('school_university');
		$is_skyline_student	=	$this->post('is_skyline_student');
		
		if($mobile_no!= '' && $email!= '' && $dob!= '' && $nationality_id!= '' && $city!= '' && $address!= '' && $program_id!= '' && $stud_prof!= '' && $school_university!= '' && $is_skyline_student!= '' )
		{
			$isUserExist 	=	$this->master_model->getRecord('aptitude_appliedstudents',array('email'=>$email),'id');
			if($isUserExist)
			{
				$answers =	$this->master_model->getRecordCount('aptitude_answer',array('student_id'=>$isUserExist['id']));
				
				if($answers>0)
				{
					$response["success"] = "0"; 
					$response["data"]= null; 
					$response["message"] = "You already submitted Apptitude Test.";
					$response["command"]="apptitudeForm"; 
					$this->set_response($response, 200);
				}
				else
				{
					$data =	$this->master_model->getRecord('aptitude_appliedstudents',array('id'=>$isUserExist['id']),'id,fname,lname,email');
					$data['questions'] =	$this->master_model->getRecords('aptitude_questions',array('is_active'=>1),'id,question',array('sequence'=>'ASC'));
					$response["success"] = "1"; 
					$response["data"] = $data;
					$response["message"] = "Your registration successful."; 
					$response["command"]="apptitudeForm"; 
					$this->set_response($response, 200);
				}
			}
			else
			{
				$insArray = array(	'fname'=>$fname,
									'mname'=>$mname,
									'lname'=>$lname,
									'email'=>$email,
									'mobile_no'=>$mobile_no,
									'tel_no'=>$tel_no,
									'dob'=>date('Y-m-d',strtotime($dob)),
									'nationality_id'=>$nationality_id,
									'city'=>$city,
									'address'=>$address,
									'program_id'=>$program_id,
									'stud_prof'=>$stud_prof,
									'school_university'=>$school_university,
									'is_skyline_student'=>$is_skyline_student);
				
				if($id=$this->master_model->insertRecord('aptitude_appliedstudents', $insArray,true))
				{
					$data =	$this->master_model->getRecord('aptitude_appliedstudents',array('id'=>$id),'id,fname,lname,email');
					$data['questions'] =	$this->master_model->getRecords('aptitude_questions',array('is_active'=>1),'id,question',array('sequence'=>'ASC'));
					$response["success"] = "1"; 
					$response["data"] = $data;
					$response["message"] = "Your registration successful."; 
					$response["command"]="apptitudeForm"; 
					$this->set_response($response, 200);
				}
				else
				{
					$response["success"] = "0"; 
					$response["data"]= null; 
					$response["message"] = "Error while registration.";
					$response["command"]="apptitudeForm"; 
					$this->set_response($response, 200);
				}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="apptitudeForm"; 
			$this->set_response($response, 200);
		}
    }		

    public function apptitudeAnswer_post()
    {
    	$question_id 	=	$this->post('question_id');
    	$student_id 	=	$this->post('student_id');
    	$answer 		=	$this->post('answer');
    	if($question_id!='' && $student_id!='' && $answer!='' )
    	{
    		$ins_arr 	=	array('question_id'=>$question_id,
    								'student_id'=>$student_id,
    								'answer'=>$answer);
    		if($this->master_model->insertRecord('aptitude_answer',$ins_arr,true))
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your answer submitted successfully."; 
				$response["command"]="apptitudeAnswer"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="apptitudeAnswer"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="apptitudeAnswer"; 
			$this->set_response($response, 200);
		}
    }
    
    public function apptitudeCompleted_post()
    {
    	$stud_id 	=	$this->post('stud_id');
    	$finish_time=	$this->post('finish_time');
    	if($stud_id!='' && $finish_time!='' )
    	{
    		$upt_arr =	array('is_completedtest'=>1,
								'finish_time'=>date('h:i:s',strtotime($finish_time)),
								'updated_date'=>date("Y-m-d H:i:s"));
    		$this->master_model->updateRecord('aptitude_appliedstudents',$upt_arr,array('id'=>$stud_id));
    		if($this->db->affected_rows())
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your Apptitude Test Completed."; 
				$response["command"]="apptitudeCompleted"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="apptitudeCompleted"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="apptitudeCompleted"; 
			$this->set_response($response, 200);
		}
    }

    public function getAdmissionFormDropdownRecords_post()
	{
			$data =  array();
			$data['countries'] = $this->dbConnect('CDB')->query("select NationalityID,NationalityName from tblNationality where IsActive = 1")->result_array();
			$data['program'] = $this->dbConnect('CDB_Academic_Pro')->query("select DegreeType_Id,DegreeType_Desc from degreeType_master where IsActive = 1 ORDER BY DegreeType_Desc ASC")->result_array();


			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getAdmissionFormDropdownRecords"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getAdmissionFormDropdownRecords"; 
				$this->set_response($response, 200);
			}
		
	}

	public function getAdmissionCourses_post()
	{
		$program_id =	$this->post('program_id');
		if($program_id!='')
		{
			$data	=	$this->master_model->getRecords('admission_program_courses',array('is_active'=>1,'program_id'=>$program_id),'id,course');
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getAdmissionCourses"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getAdmissionCourses"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAdmissionCourses"; 
			$this->set_response($response, 200);
		}
	}

    public function admissionForm_post()
    {
		$title       =    $this->post('title');
		$gender      =    $this->post('gender');
		$fname       =    $this->post('fname');
		$mname       =    $this->post('mname');
		$lname       =    $this->post('lname');
		$email       =    $this->post('email');
		$dob         =    $this->post('dob');
		$student_visa     =     $this->post('student_visa');
		$hostel_facility  =     $this->post('hostel_facility');
		$address          =     $this->post('address');
		$suburb           =     $this->post('suburb');
		$state            =     $this->post('state');
		$postal_code      =     $this->post('postal_code');
		$country_id       =     $this->post('country_id');
		$telphone_no      =     $this->post('telphone_no');
		$mobile_no        =     $this->post('mobile_no');
		$home_address     =     $this->post('home_address');
		$home_suburb      =     $this->post('home_suburb');
		$home_state       =     $this->post('home_state');
		$home_postal_code =     $this->post('home_postal_code');
		$home_country_id  =     $this->post('home_country_id');
		$home_telphone_no =     $this->post('home_telphone_no');
		$home_mobile_no   =     $this->post('home_mobile_no');
		$nationality_id   =     $this->post('nationality_id');
		$country_permanent=     $this->post('country_permanent');
		$country_of_birth =     $this->post('country_of_birth');
		$is_international_student     =   $this->post('is_international_student');
		$program_preference1          =  $this->post('program_preference1');
		$course_preference1     =     $this->post('course_preference1');
		$program_preference2    =     $this->post('program_preference2');
		$course_preference2     =     $this->post('course_preference2');
		$begin_degree           =     $this->post('begin_degree');
		$distance_learning      =     $this->post('distance_learning');
		$underwent_sat_exam     =     $this->post('underwent_sat_exam');
		$sat_score              =     $this->post('sat_score');
		$english_proficiency    =     $this->post('english_proficiency');
		$english_proficiency_year     =     $this->post('english_proficiency_year');
		$english_proficiency_overall  =     $this->post('english_proficiency_overall');
		$institution_name       =     $this->post('institution_name');
		$qualifications       	=     json_decode($this->post('qualifications'),true);
		$employements       	=     json_decode($this->post('employements'),true);
		
		if($title!='' && $gender!='' && $fname!='' && $lname!='' && $email!='' && $dob!='' && $student_visa!='' && $hostel_facility!='' && $address!='' && $suburb!='' && $state!='' && $postal_code!='' && $country_id!='' && $telphone_no!='' && $mobile_no!='' && $home_address!='' && $home_suburb!='' && $home_state!='' && $home_postal_code!='' && $home_country_id!='' && $home_telphone_no!='' && $home_mobile_no!='' && $nationality_id!='' && $country_permanent!='' && $country_of_birth!='' && $is_international_student!='' && $program_preference1!='' && $course_preference1!='' && $begin_degree!='' && $distance_learning!='' && $underwent_sat_exam!='' && $english_proficiency!='' && $english_proficiency_year!='')
		{
			$insArray	= 	array('title' => $title,
								'gender' => $gender,
								'fname' => $fname,
								'mname' => $mname,
								'lname' => $lname,
								'email' => $email,
								'dob' => date('Y-m-d',strtotime($dob)),
								'student_visa' => $student_visa,
								'hostel_facility' => $hostel_facility,
								'address' => $address,
								'suburb' => $suburb,
								'state' => $state,
								'postal_code' => $postal_code,
								'country_id' => $country_id,
								'telphone_no' => $telphone_no,
								'mobile_no' => $mobile_no,
								'home_address' => $home_address,
								'home_suburb' => $home_suburb,
								'home_state' => $home_state,
								'home_postal_code' => $home_postal_code,
								'home_country_id' => $home_country_id,
								'home_telphone_no' => $home_telphone_no,
								'home_mobile_no' => $home_mobile_no,
								'nationality_id' => $nationality_id,
								'country_permanent' => $country_permanent,
								'country_of_birth' => $country_of_birth,
								'is_international_student' => $is_international_student,
								'program_preference1' => $program_preference1,
								'course_preference1' => $course_preference1,
								'program_preference2' => $program_preference2,
								'course_preference2' => $course_preference2,
								'begin_degree' => $begin_degree,
								'distance_learning' => $distance_learning,
								'underwent_sat_exam' => $underwent_sat_exam,
								'sat_score' => $sat_score,
								'english_proficiency' => $english_proficiency,
								'english_proficiency_year' => $english_proficiency_year,
								'english_proficiency_overall' => $english_proficiency_overall,
								'institution_name' => $institution_name);
			
			$this->db->trans_begin();
			if($id=$this->master_model->insertRecord('admission_student', $insArray,true))
			{
				if(count($qualifications)>0)
				{
					foreach ($qualifications as $row) {
						$row['student_id'] 	=	$id;
						$this->master_model->insertRecord('admission_student_qualification',$row);		
					}
				}

				if(count($employements)>0)
				{
					foreach ($employements as $row) {
						$row['student_id'] 	=	$id;
						$this->master_model->insertRecord('admission_student_employement',$row);		
					}
				}

				if ($this->db->trans_status() === FALSE)
				{
					$this->db->trans_rollback();
					$response["success"] = "0"; 
					$response["data"]= null; 
					$response["message"] = "Error while registration.";
					$response["command"]="admissionForm"; 
					$this->set_response($response, 200);
				}
				else
				{	
					$this->db->trans_commit();
					$response["success"] = "1"; 
					$response["data"] = null;
					$response["message"] = "Your registration successful."; 
					$response["command"]="admissionForm"; 
					$this->set_response($response, 200);
				}
			}
			else
			{
				$this->db->trans_rollback();
				$response["success"] = "0"; 
				$response["data"]= null; 
				$response["message"] = "Error while registration.";
				$response["command"]="admissionForm"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="admissionForm"; 
			$this->set_response($response, 200);
		}
    }

    public function getResultSetting_post()
	{
		
			$data	=	$this->master_model->getRecords('settings_result',array('is_active'=>1),'name,is_enabled',array('id'=>'ASC'));
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getResultSetting"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Result setting record not found.";
				$response["command"]="getResultSetting"; 
				$this->set_response($response, 200);
			}
		
	}
	
	public function getDirectories_post()
	{
	
			$data['department']	=	$this->master_model->getRecords('directory_department','','id,name',array('name'=>'ASC'));
			$data['directory'] 	=	$this->db->query("SELECT directory.id, department, dept.name as dept_name, directory.name, position, phone1, mobile1, email
													FROM directory_master directory
													JOIN directory_department dept ON dept.id=directory.department
													WHERE directory.is_active = 1
													GROUP BY directory.department,directory.id, dept.name, directory.name, position, phone1, mobile1, email
													ORDER BY dept.name ASC")->result_array();
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getDirectories"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getDirectories"; 
				$this->set_response($response, 200);
			}
		
	}
	/*Guest module : END */
	

	/*Common module : Start */

	public function login_post()
	{
		try
		{

		$username 	=	$this->post('username');
		$password 	=	$this->post('password');
	
		
		if($username!='' && $password!='' )
		{
			
		
			$sql =	"SELECT * FROM (SELECT empnumber as id,login_name,CAST( CASE WHEN employeetype = 'FACULTY' THEN 'FAC' WHEN employeetype = 'STAFF' THEN 'STF' END as varchar) as user_type FROM SP_Mobile_App_login where login_name like ? UNION SELECT case when student_id like '%R%' then ltrim(substring(student_id,8,len(student_id))) else student_id end as id,case when student_id like '%R%' then ltrim(substring(student_id,8,len(student_id))) else student_id end as login_name,'STUDENT' as user_type FROM Students_login WHERE case when student_id like '%R%' then ltrim(substring(student_id,8,len(student_id))) else student_id end = ? )  result";
		//	$time_start = microtime(true); 
					$result =	$this->dbConnect('portal')->query($sql,array($username,$password))->row_array();
					//echo 'Total execution time in seconds: ' . (microtime(true) - $time_start);

			if($result)
			{
				if($this->authMain($username, $password))
				{
				
					
					if($result['user_type']=='STUDENT')
					{
						$this->db1 	=	$this->dbConnect('AdminExam');
						
						
													$sql =	"SELECT  distinct  [User ID] as user_id,Name as name,semester_name as semester,Degreetype as program,acadyear_desc,Gender,CONVERT(varchar, DOB, 101) as DOB from Portal_For_Student_App where [User ID] = ?";


						$data =	$this->db1->query($sql,array($result['id']))->row_array();
						if($data)
						{
						$data['user_type']=$result['user_type'];
						$this->db->where("(type='".$result['user_type']."' OR type='All')");
						
						
						$response["success"] = "1";
						$response["data"] = $data;
						$response["message"] =""; 
						$response["command"]="login"; 
					
					
					
						$response["photo"]= $this->getImageST($result['id'],$result['user_type']);
						
						$this->set_response($response, 200);
						}else{ 
						
							$response["success"] = "0";
							$response["data"] = null;
							$response["message"] ="User info not available..."; 
							$response["command"]="login"; 
							$this->set_response($response, 200);
						}
						
					}
					
					else if($result['user_type']=='STF')
					{
						$this->db1 	=	$this->dbConnect('AdminExam');
						$sql =	"SELECT top 1 staff_id as user_id,staff_name as name,semester,null as program, academicyear as acadyear_desc 
						        FROM Portal_For_STAFF 
						        WHERE STAFF_ID = ?";
						$data =	$this->db1->query($sql,array($result['id']))->row_array();

						$data['user_type']=$result['user_type'];
						$this->db->where("(type='".$result['user_type']."' OR type='All')");
						

						$response["success"] = "1";
						$response["data"] = $data;
						$response["message"] =""; 
						$response["command"]="login"; 
						
						
					
						
						$response["photo"]=$this->getImageST($result['id'],$result['user_type']);
						
						$this->set_response($response, 200);
					}

					else if($result['user_type']=='FAC')
					{
						$this->db1 	=	$this->dbConnect('AdminExam');
						$sql =	"SELECT distinct faculty_id as user_id, facultyname as name, semester_name as semester,program,acadyear_desc
								FROM Portal_For_FacultyStudent 
								WHERE faculty_id = ?";
						$data =	$this->db1->query($sql,array($result['id']))->row_array();
						$data['user_type']=$result['user_type'];
						$this->db->where("(type='".$result['user_type']."' OR type='All')");
					
					

						$response["success"] = "1";
						$response["data"] = $data;
						$response["message"] =""; 
						$response["command"]="login"; 
						
					
						$response["photo"]=$this->getImageST($result['id'],$result['user_type']);
					
						$this->set_response($response, 200);
					}
					else
					{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Invalid user credentials..!"; 
					$response["command"]="login"; 
					$this->set_response($response, 200);		
					}
				}
				else
				{

					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Invalid users credentials..!"; 
					$response["command"]="login"; 
					$this->set_response($response, 200);		
				}
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Invalid user credentials..!"; 
				$response["command"]="login"; 
				$this->set_response($response, 200);		
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="login"; 
			$this->set_response($response, 200);
		}
	} catch (Exception $e) {
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Please contact admin..!"; 
				$response["command"]="login"; 
				$this->set_response($response, 200);		
	}
	
	}

	public function getHomeAnnouncementAndCalendar_post()
	{
		$user_type 	=	$this->post('usertype');
		if($user_type!='' )
		{
			$data = array();
			$this->db->where("(type='".$user_type."' OR type='All')");
			$data['announcements']=$this->master_model->getRecords('announcements',array('is_active'=>1),'id,title,date_time,description',array('id'=>'DESC'),0,10);
			$this->db1 	=	$this->dbConnect('DB_SkylineCalendarEvents');
			$sql =	"select * from (
					select top 5 * from VW_Calendar_DATA where category1 like '%ACADEMIC CALENDAR - BBA - WEEKDAYS%' AND eventstartdt >= GETDATE()
					UNION
					select top 5 * from VW_Calendar_DATA where category1 like '%ACADEMIC CALENDAR - BBA - WEEKEND%' AND eventstartdt >= GETDATE()
					UNION
					select top 5 * from VW_Calendar_DATA where category1 like '%ACADEMIC CALENDAR - MBA - WEEKDAYS%' AND eventstartdt >= GETDATE()
					UNION
					select top 5 * from VW_Calendar_DATA where category1 like '%ACADEMIC CALENDAR - MBA - WEEKEND%' AND eventstartdt >= GETDATE()
					UNION
					select top 5 * from VW_Calendar_DATA where category1 like '%ACADEMIC CALENDAR - AIPC%' AND eventstartdt >= GETDATE()
					) as cresult  ORDER BY EVENTSTARTDT";
			$data['calendar']=	$this->db1->query($sql)->result_array();
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getHomeAnnouncementAndCalendar"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getHomeAnnouncementAndCalendar"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getHomeAnnouncementAndCalendar"; 
			$this->set_response($response, 200);
		}
	}
	//auth function 
	public function authMain($userName, $usrPass){
	  
	    if($userName == 'saravanakumar' && $usrPass == 'saravana144')
        {
             return 1;  
        }

		$ldappass = 'Aasky2008';  // associated password*/
	   

	    $ldaprdn  = $userName.'@skylineuniversity.ac.ae';
	    $ldappass = $usrPass;  
		$ldapconn = ldap_connect("192.168.167.3") or die("Could not connect to LDAP server.");
	    if ($ldapconn) {
	      	$ldapbind = ldap_bind($ldapconn, $ldaprdn, $ldappass); 
		   
		    if ($ldapbind) 
		    	{	
				return 1;  
				  } 
		    else{
			return 0;
			}

	   	}

	}

	public function getRequestFormsText_post()
	{
		$name 	= 	$this->post('name');
		$user_id= 	$this->post('user_id');
		if($name!='' && $user_id!='')
		{
			$data	=	$this->db->query("select description from requestforms_policy where name= ?",array($name))->row_array();
			if($name=='passportretainingterms')
			{
				$this->db1 	=	$this->dbConnect('payroll');
				$text =	$this->db1->query("exec sHp_GetPassportdetails ?",array($user_id))->row_array();
				$data['personal_undertaking']=$text['PERSONAL UNDERTAKING'];
			}

			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getRequestFormsText"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getRequestFormsText"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getRequestFormsText"; 
			$this->set_response($response, 200);
		}
	}


	public function getNotifications_post()
	{
		$user_id 	=	$this->post('user_id');
		$user_type 	=	$this->post('usertype');
		if($user_id!='' && $user_type!='')
		{
			$data	=	$this->master_model->getRecords('notifications',array('is_active'=>1,'user_id'=>$user_id,'type'=>$user_type),'id,title,description,published_datetime',array('id'=>'ASC'));

			$deviceid 	=	$this->post('deviceid');
    		$upt_arr =	array('is_read'=>1,'read_date'=>date("Y-m-d H:i:s"));
    		$this->master_model->updateRecord('notifications',$upt_arr,array('device_id'=>$deviceid,'is_read'=>0));
    		
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getNotifications"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getNotifications"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getNotifications"; 
			$this->set_response($response, 200);
		}
	}
	

	/*Common module : END */


	/*Student module : START*/

	public function getAnnouncements_post()
	{
		$usertype = $this->post('usertype');
		if($usertype!='' )
		{	
			$this->db->where("(type='All' OR type='".$usertype."')");
			$data	=	$this->master_model->getRecords('announcements',array('is_active'=>1),'id,title,date_time,description',array('id'=>'DESC'));
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getAnnouncements"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getAnnouncements"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAnnouncements"; 
			$this->set_response($response, 200);
		}
	}


	public function StudentAttendance_post()
	{
		$student_id 	=	$this->post('student_id');
		
		if($student_id!='' )
		{	
			
			$cblock = $this->checkBlock($student_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getDownloadLink"; 
				$this->set_response($response, 200);
			}else
			{
			$this->db1 	=	$this->dbConnect('MYFENCE');

			$sql =	"exec SP_CONSOLIDATED_NEGPERCENTAGE_PORTAL 0,0,?";


			
			$data =	$this->db1->query($sql,array($student_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getStudentAttendance"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Student attendance not available."; 
				$response["command"]="getStudentAttendance"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getStudentAttendance"; 
			$this->set_response($response, 200);
		}
	}

	public function StudentAttendanceDetails_post()
	{
		$student_id 	=	$this->post('student_id');
		$class_section_id 	=	$this->post('class_section_id');
		
		if($student_id!='' && $class_section_id!='')
		{	



//tblAttendance

$this->db1 	=	$this->dbConnect('MYFENCE');


			$sql =	"SELECT ROW_NUMBER() over (order by id desc) as [S.No],[Setion],[ClassSectionId],convert (varchar, cast(CreatedDate as datetime),103) as [Attendance Taken On] ,case when IsPresent='P' then 'PRESENT' else 'ABSENT' end   as Attendance       from tblAttendance where [RollNo] = ? and [ClassSectionId] = ? ";






			$data =	$this->db1->query($sql,array($student_id,$class_section_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getStudentAttendanceDetails"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Attendance details not found."; 
				$response["command"]="getStudentAttendanceDetails"; 
				$this->set_response($response, 200);		
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getStudentAttendanceDetails"; 
			$this->set_response($response, 200);
		}
	}

	public function classScheduleCourseDetails_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='' )
		{	
			$this->db1 	=	$this->dbConnect('Portal');
			$sql =	"exec SHP_PORTAL_COURSENAME ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="classScheduleCourseDetails"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="classScheduleCourseDetails"; 
				$this->set_response($response, 200);		
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="classScheduleCourseDetails"; 
			$this->set_response($response, 200);
		}
	}


	public function classScheduleWeekday_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"AdminExam", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if($conn)
			{
				$result = sqlsrv_query($conn,'exec SHP_StudentClassWeekDay_New ?',array($user_id)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="classScheduleWeekday"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    if( $next_result ) 
					    {
					        while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
					        {   
					        	$data[] =	$row;	
					        }
					    }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{
					$response["success"] = "1";
					$response["data"] = $data;
					$response["message"] =""; 
					$response["command"]="classScheduleWeekday"; 
					$this->set_response($response, 200);			
				}
				else
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Records not found."; 
					$response["command"]="classScheduleWeekday"; 
					$this->set_response($response, 200);		
				} 
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="classScheduleWeekday"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="classScheduleWeekday"; 
			$this->set_response($response, 200);
		}
	}


	public function classScheduleWeekend_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"AdminExam", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if($conn)
			{
				$result = sqlsrv_query($conn,'exec SHP_CLASSCHEDULE_WEEKEND_WEBSITE ?',array($user_id)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="classScheduleWeekend"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    if( $next_result ) 
					    {
					        while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
					        {   
					        	$data[] =	$row;	
					        }
					    }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{
					$response["success"] = "1";
					$response["data"] = $data;
					$response["message"] =""; 
					$response["command"]="classScheduleWeekend"; 
					$this->set_response($response, 200);			
				}
				else
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Records not found."; 
					$response["command"]="classScheduleWeekend"; 
					$this->set_response($response, 200);		
				} 
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="classScheduleWeekend"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="classScheduleWeekend"; 
			$this->set_response($response, 200);
		}
	}

	public function classScheduleMQPWeekday_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='' )
		{	
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"Portal", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if($conn)
			{
				$result = sqlsrv_query($conn,'exec SHP_ClassSchedule_MQPWEEKDAY_WEBSITE ?',array($user_id)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="classScheduleMQPWeekday"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    if( $next_result ) 
					    {
					        while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
					        {   
					        	$data[] =	$row;	
					        }
					    }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{
					$response["success"] = "1";
					$response["data"] = $data;
					$response["message"] =""; 
					$response["command"]="classScheduleMQPWeekday"; 
					$this->set_response($response, 200);			
				}
				else
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Records not found."; 
					$response["command"]="classScheduleMQPWeekday"; 
					$this->set_response($response, 200);		
				} 
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="classScheduleMQPWeekday"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="classScheduleMQPWeekday"; 
			$this->set_response($response, 200);
		}
	}

	public function classScheduleMQPWeekend_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"Portal", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if($conn)
			{
				$result = sqlsrv_query($conn,'exec SHP_ClassSchedule_MQPWEEKEND_WEBSITE ?',array($user_id)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="classScheduleMQPWeekend"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    if( $next_result ) 
					    {
					        while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
					        {   
					        	$data[] =	$row;	
					        }
					    }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{
					$response["success"] = "1";
					$response["data"] = $data;
					$response["message"] =""; 
					$response["command"]="classScheduleMQPWeekend"; 
					$this->set_response($response, 200);			
				}
				else
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Records not found."; 
					$response["command"]="classScheduleMQPWeekend"; 
					$this->set_response($response, 200);		
				} 
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="classScheduleMQPWeekend"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="classScheduleMQPWeekend"; 
			$this->set_response($response, 200);
		}
	}

	public function assessmentMarkCourses_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="assessmentMarkCourses"; 
				$this->set_response($response, 200);
			}
			else
			{
			$this->db1 	=	$this->dbConnect('AdminExam');
			$sql =	"exec SP_GETASSESSMENT_COURSES ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="assessmentMarkCourses"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="assessmentMarkCourses"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="assessmentMarkCourses"; 
			$this->set_response($response, 200);
		}
	}

	public function assessmentMarks_post()
	{
		$user_id 	=	$this->post('user_id');
		$course_id 	=	$this->post('course_id');
		if($user_id!='' && $course_id!='')
		{	
			$this->db1 	=	$this->dbConnect('AdminExam');
			$sql =	"exec sp_assessmentmarkbatchwise ?,?";
			$data =	$this->db1->query($sql,array($user_id,$course_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="assessmentMarks"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="assessmentMarks"; 
				$this->set_response($response, 200);		
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="assessmentMarks"; 
			$this->set_response($response, 200);
		}
	}

	//TODO: Here change to open Files

	public function studyMaterialCourses_post()
	{
		$user_id 	=	$this->post('user_id');
		
		if($user_id!='' )
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="studyMaterialCourses"; 
				$this->set_response($response, 200);
			}
			else
			{	
			$this->db1 	=	$this->dbConnect('AdminExam');
			$sql 	=	"SELECT faculty_id,batchcode,facultyname,semester_name,stud_id,cdd_code as course_code 
						FROM Portal_For_StudyMaterial 
						where stud_id = ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="studyMaterialCourses"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="studyMaterialCourses"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="studyMaterialCourses"; 
			$this->set_response($response, 200);
		}
	}


	

	// public function getStudyMaterialCourseDetails_post()
	// {
	// 	$faculty_id =	$this->post('faculty_id');
	// 	$batch_code =	$this->post('batch_code');
	// 	$course_id 	=	$this->post('course_id');
	// 	if($faculty_id!='' && $batch_code!='' && $course_id!='' )
	// 	{	
	// 		//$sql 	=	"SELECT id,title,subject,facultyname,semester,uploaded_date,path,faculty_id,batch_code 
	// 		//			FROM studymaterial_details
	// 		//			WHERE is_active = 1 
	// 		//			AND faculty_id = ?
	// 		//			AND batch_code = ? 
	// 		//			AND course_id =? ";
	// 		$sql="select id,filename as title,subject,facultyname,semester,filecreated as uploaded_date,(tuip.linkname+tuip.foldername+filepath) as path,facultyid as faculty_id,batchcode as batch_code from Tbl_Study_Material,Tbl_DocImage_Path tuip where tuip.type='other' and batchcode='". $batch_code ."' and filetype not like '%.zip' order by filecreated desc";
	// 		//$data =	$this->db->query($sql,array($faculty_id,$batch_code,$course_id))->result_array();
	// 		//$data =	$this->db->query($sql,array($batch_code))->result_array();
	// 		$data =	$this->db->query($sql)->result_array();
	// 		if($data)
	// 		{
	// 			$response["success"] = "1";
	// 			$response["data"] = $data;
	// 			$response["message"] =""; 
	// 			$response["command"]="getStudyMaterialCourseDetails"; 
	// 			$this->set_response($response, 200);			
	// 		}
	// 		else
	// 		{
	// 			$response["success"] = "0";
	// 			$response["data"] = null;
	// 			$response["message"] ="Records not found."; 
	// 			$response["command"]="getStudyMaterialCourseDetails"; 
	// 			$this->set_response($response, 200);		
	// 		}
	// 	}
	// 	else
	// 	{
	// 		$response["success"] = "0";
	// 		$response["data"] = null;
	// 		$response["message"] ="You didn't provide a required parameter."; 
	// 		$response["command"]="getStudyMaterialCourseDetails"; 
	// 		$this->set_response($response, 200);
	// 	}
	// }

	public function getCDPCourse_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getOnlineRequestTypes"; 
				$this->set_response($response, 200);
			}
			else
			{	
		
			$sql 	=	"exec SHP_cpdfacutybatchcode ?";
			$data =	$this->dbConnect('AdminExam')->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getCDPCourse"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getCDPCourse"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCDPCourse"; 
			$this->set_response($response, 200);
		}
	}	

	public function getFinalTermResults_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getFinalTermResults"; 
				$this->set_response($response, 200);
			}
			else
			{	
			
			$sql 	=	"exec SHP_FInalTerm_Portal ?";
			$data =	$this->dbConnect('Portal')->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getFinalTermResults"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getFinalTermResults"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getFinalTermResults"; 
			$this->set_response($response, 200);
		}
	}	

	public function getFinalTermMarks_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getFinalTermResults"; 
				$this->set_response($response, 200);
			}
			else
			{	
			$this->db1 	=	$this->dbConnect('Portal');
			$sql 	=	"exec SHP_FInalTermMarksONLY_Portal ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getFinalTermMarks"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getFinalTermMarks"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getFinalTermMarks"; 
			$this->set_response($response, 200);
		}
	}

	public function getMidTermMarks_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getFinalTermResults"; 
				$this->set_response($response, 200);
			}
			else
			{	
			$this->db1 	=	$this->dbConnect('AdminExam');
			$sql 	=	"exec SHP_midterm ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getMidTermMarks"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getMidTermMarks"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getMidTermMarks"; 
			$this->set_response($response, 200);
		}
	}

	public function StudentGPAProfile_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getOnlineRequestTypes"; 
				$this->set_response($response, 200);
			}
			else
			{	
			$this->db1 	=	$this->dbConnect('AdminExam');
			$sql 	=	"exec SHP_GetAcademicProfile_Student_Details ?";
			$data =	$this->db1->query($sql,array($user_id))->row_array();
			
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getStudentGPAProfile"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getStudentGPAProfile"; 
				$this->set_response($response, 200);		
			}
			}

		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getStudentGPAProfile"; 
			$this->set_response($response, 200);
		}
	}

	public function GPARequirments_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$cblock = $this->checkBlock($user_id);
			if(!empty($cblock))
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] =$cblock; 
				$response["command"]="getOnlineRequestTypes"; 
				$this->set_response($response, 200);
			}
			else{	
			$this->db1 	=	$this->dbConnect('AdminExam');
			$sql 	=	"exec SHP_ACAPROFILE_REQUIREMENTS ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getGPARequirments"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getGPARequirments"; 
				$this->set_response($response, 200);		
			}
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getGPARequirments"; 
			$this->set_response($response, 200);
		}
	}
	public function MyAdvisors_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$this->db1 	=	$this->dbConnect('portal');
			$sql 	=	"exec SP_POPULATE_ADVISOR ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getMyAdvisors"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getMyAdvisors"; 
				$this->set_response($response, 200);		
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getMyAdvisors"; 
			$this->set_response($response, 200);
		}
	}
//TODO: check time
	public function AdvisorSchedule_post()
	{
		$user_id 	=	$this->post('user_id');
		if($user_id!='')
		{	
			$this->db1 	=	$this->dbConnect('portal');
			$sql 	=	"exec SHP_SP_ADV_STUD_TIMETABLENEW ?";
			$data =	$this->db1->query($sql,array($user_id))->result_array();
			if($data)
			{
				$response["success"] = "1";
				$response["data"] = $data;
				$response["message"] =""; 
				$response["command"]="getAdvisorSchedule"; 
				$this->set_response($response, 200);			
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Records not found."; 
				$response["command"]="getAdvisorSchedule"; 
				$this->set_response($response, 200);		
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAdvisorSchedule"; 
			$this->set_response($response, 200);
		}
	}

	// public function getAdvisorAppointment_post()
	// {
	// 	$user_id 	=	$this->post('user_id');
	// 	if($user_id!='' && $this->loghistory('Get advisor appointment'))
	// 	{	
	// 		$this->db1 	=	$this->dbConnect('portal');
	// 		$sql 	=	"exec sp_LoadBasic_CounselingStudentsDEtails ?";
	// 		$data =	$this->db1->query($sql,array($user_id))->result_array();
	// 		if($data)
	// 		{
	// 			$response["success"] = "1";
	// 			$response["data"] = $data;
	// 			$response["message"] =""; 
	// 			$response["command"]="getAdvisorAppointment"; 
	// 			$this->set_response($response, 200);			
	// 		}
	// 		else
	// 		{
	// 			$response["success"] = "0";
	// 			$response["data"] = null;
	// 			$response["message"] ="Records not found."; 
	// 			$response["command"]="getAdvisorAppointment"; 
	// 			$this->set_response($response, 200);		
	// 		}
	// 	}
	// 	else
	// 	{
	// 		$response["success"] = "0";
	// 		$response["data"] = null;
	// 		$response["message"] ="You didn't provide a required parameter."; 
	// 		$response["command"]="getAdvisorAppointment"; 
	// 		$this->set_response($response, 200);
	// 	}
	// }





	// public function getIELTS_post()
	// {
	// 	$user_id 	=	$this->post('user_id');
	// 	if($user_id!='' && $this->loghistory('Get IELTS'))
	// 	{	
	// 		$cblock = $this->checkBlock($user_id);
	// 		if(!empty($cblock))
	// 		{
	// 			$response["success"] = "0";
	// 			$response["data"] = null;
	// 			$response["message"] =$cblock; 
	// 			$response["command"]="getIELTS"; 
	// 			$this->set_response($response, 200);
	// 		}
	// 		else
	// 		{	
	// 		$data = array();
	// 		$text 	=	$this->master_model->getRecord('ielts_resulttext');
			
	// 		$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
	// 		$connectionInfo = array( "Database"=>"AdminExam", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
	// 		$conn = sqlsrv_connect( $serverName, $connectionInfo);

	// 		if( $conn )
	// 		{
	// 			$result1 = sqlsrv_query($conn,'exec sp_IELTSNAME ?',array($user_id)); 
	// 			$result2 = sqlsrv_query($conn,'exec sp_IELTSWorkshopResults ?',array($user_id)); 

	// 			if ($result1 === FALSE || $result2 === FALSE) 
	// 			{
	// 				$response["success"] = "0";
	// 				$response["data"] = null;
	// 				$response["message"] ="Something went wrong."; 
	// 				$response["command"]="getAcademicProfileCourse"; 
	// 				$this->set_response($response, 200);
	// 			}
	// 			else
	// 			{
	// 		        while($row = sqlsrv_fetch_array($result1,SQLSRV_FETCH_NUMERIC))
	// 		        {   
	// 		        	$data[] =	$row;	
	// 		        }
					 
	// 				while($next_result=sqlsrv_next_result($result2))
	// 				{
	// 					$data[] = sqlsrv_fetch_array($result2,SQLSRV_FETCH_ASSOC);
	// 				}
	// 			}
	// 			sqlsrv_close( $conn);
	// 			if(count($text)>0 && count($data[0])>0 && count($data[1])>0)
	// 			{
	// 				$response["success"] = "1";
	// 				$response["data"] = $data[0][0]." ".$text['static_text1']." ".$data[1]['Module']."-".$data[1]['Score']." ".$text['static_text2'];
	// 				$response["message"] =""; 
	// 				$response["command"]="getIELTS"; 
	// 				$this->set_response($response, 200);			
	// 			}
	// 			else
	// 			{
	// 				$response["success"] = "0";
	// 				$response["data"] = null;
	// 				$response["message"] ="Record not found."; 
	// 				$response["command"]="getIELTS"; 
	// 				$this->set_response($response, 200);		
	// 			}
	// 		}
	// 		else
	// 		{
	// 			$response["success"] = "0";
	// 			$response["data"] = null;
	// 			$response["message"] ="Something went wrong."; 
	// 			$response["command"]="getAcademicProfileCourse"; 
	// 			$this->set_response($response, 200);
	// 		}
	// 		}
	// 	}
	// 	else
	// 	{
	// 		$response["success"] = "0";
	// 		$response["data"] = null;
	// 		$response["message"] ="You didn't provide a required parameter."; 
	// 		$response["command"]="getIELTS"; 
	// 		$this->set_response($response, 200);
	// 	}
	// }


	public function OnlineRequestTypes_post()
	{
		$user_id 	=	$this->post('user_id');
		$program 	=	$this->post('program');

		$cblock = "";//$this->checkBlock($user_id);
		if(0)
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="getOnlineRequestTypes"; 
			$this->set_response($response, 200);
		}
		else{	
		$cblock2 = $this->checkOnlineRequestBlock($user_id);
		if(!empty($cblock2))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock2; 
			$response["command"]="getOnlineRequestTypes"; 
			$this->set_response($response, 200);
		}
		else{	
		if($user_id!='' && $program!='')
		{
			$this->db1 	=	$this->dbConnect('Adminexam');
			//$data=	$this->db1->query("exec SP_PopulateRequestType ?,'SingleStudent',?",array($user_id,$program))->result_array();

			$data=	$this->db1->query("exec SHP_PopulateRequestType_mobileApp ?,?",array($user_id,$program))->result_array();
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getOnlineRequestTypes "; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getOnlineRequestTypes"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getOnlineRequestTypes"; 
			$this->set_response($response, 200);
		}
		}
		}
	}


	
	// public function OnlineRequestAmount_post()
	// {
	
	// 	$MiscID 	=	$this->post('MiscID');
	// 	$program 	=	$this->post('program');
	// 		$user_id 	=	$this->post('user_id');

	

	// 	$cblock = "";//$this->checkBlock($user_id);
	// 	if(0)
	// 	{
	// 		$response["success"] = "0";
	// 		$response["data"] = null;
	// 		$response["message"] =$cblock; 
	// 		$response["command"]="getOnlineRequestAmount"; 
	// 		$this->set_response($response, 200);
	// 	}
	// 	else{	
	// 	$cblock2 = $this->checkOnlineRequestBlock($user_id);
	// 	if(!empty($cblock2))
	// 	{
	// 		$response["success"] = "0";
	// 		$response["data"] = null;
	// 		$response["message"] =$cblock2; 
	// 		$response["command"]="getOnlineRequestAmount"; 
	// 		$this->set_response($response, 200);
	// 	}
	// 	else{	
	// 	if($user_id!='' && $program!='' && $MiscID!='')
	// 	{

		



	// 		$data=	$this->dbConnect('AdminExam')->query("exec SHP_Mischleneous_Fees_New ?,?",array($MiscID,$program))->result_array();
			
	// 		if($data)
	// 		{	
	// 			$response["success"] = "1"; 
	// 			$response["data"] = $data;
	// 			$response["message"] = "";
	// 			$response["command"]="getOnlineRequestAmount "; 
	// 			$this->set_response($response, 200);
	// 		}
	// 		else
	// 		{
	// 			$response["success"] = "0"; 
	// 			$response["data"] = null; 
	// 			$response["message"] = "Records not found.";
	// 			$response["command"]="getOnlineRequestAmount"; 
	// 			$this->set_response($response, 200);
	// 		}
	// 	}
	// 	else
	// 	{
	// 		$response["success"] = "0";
	// 		$response["data"] = null;
	// 		$response["message"] ="You didn't provide a required parameter."; 
	// 		$response["command"]="getOnlineRequestAmount"; 
	// 		$this->set_response($response, 200);
	// 	}
	// 	}
	// 	}
	// }
	

	//TODO: change to online Request out 


	
	public function onlineRequestOnline_post()
	{
		$Operation 	=	$this->post('Operation'); //ONLINE | LETTER | PROCESS FORM
    	$user_id 	=	$this->post('user_id');

		
		if($Operation!='' && $user_id!='')
		{
			$data=	$this->dbConnect('Adminexam')->query("exec SP_OnlineRequestType_LMS ?",array($Operation))->result_array();
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getOnlineRequestTypes"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getOnlineRequestTypes"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter"; 
			$response["command"]="getOnlineRequestTypes"; 
			$this->set_response($response, 200);
		}
	}
	
	//tb_StudentRequest_Online
	public function onlineRequest_post()
    {
		$user_id 		=	$this->post('user_id');
		$RequestTypeid   =   $this->post('RequestTypeid');
		$RequestType 	=	$this->post('RequestType');
    	$address 		=	$this->post('address');
		$StudRemarks 		=	$this->post('StudRemarks');
		
    	if($user_id!='' && $RequestType!='' && $RequestTypeid!='' && $address!='' && $StudRemarks!='')
    	{
		
			$ins_arr 	=	array('StudentID'=>$user_id,
									'RequestTypeid'=>$RequestTypeid,
									'RequestType'=>$RequestType,
									'AddressTo'=>$address,
									'StudRemarks'=>$StudRemarks,
									'CreatedBy'=>$user_id);
									

									$data =	$this->dbConnect('Portal')->insert("tb_StudentRequest_Online",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="onlineRequest"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="onlineRequest"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="onlineRequest"; 
			$this->set_response($response, 200);
		}
    }
	




	public function CurrentAndNewShift_post()
	{
		$user_id =	$this->post('user_id');
		if($user_id!='')
		{
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="getCurrentAndNewShift"; 
			$this->set_response($response, 200);
		}
		else{
		
			$data['current_shift']	=	$this->dbConnect('portal')->query("exec SHP_PopulateStudent_ReqestDetails ?,'STUDENTSHIFT',0",array($user_id))->row_array();
			$data['new_shift']	=	$this->dbConnect('portal')->query("exec SHP_PopulateStudent_ReqestDetails ?,'SHIFTLIST',0",array($user_id))->result_array();
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCurrentAndNewShift"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCurrentAndNewShift"; 
				$this->set_response($response, 200);
			}
		}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCurrentAndNewShift"; 
			$this->set_response($response, 200);
		}
	}
//Tbl_ChangeClassTiming
	public function changeClassTiming_post()
    {
    	$user_id 	=	$this->post('user_id');
    	$CurrentTiming	=	$this->post('CurrentTiming');
    	$NewTiming =	$this->post('NewTiming');
    	$reason 	=	$this->post('reason');
    	if($user_id!='' && $CurrentTiming!='' && $NewTiming!='' && $reason!='')
    	{
    		$ins_arr 	=	array('UserID'=>$user_id,
								'CurrentTiming'=>$CurrentTiming,
								'NewTiming'=>$NewTiming,
								'Reason'=>$reason,
								'CreatedBy'=>$user_id);
								$data =	$this->dbConnect('Portal')->insert("Tbl_ChangeClassTiming",$ins_arr);

    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="changeClassTiming"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="changeClassTiming"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter.$user_id "; 
			$response["command"]="changeClassTiming"; 
			$this->set_response($response, 200);
		}
	}
	
	/*

   	public function getAppealReinstatementPolicy_post()
	{
		if($this->loghistory('Get Appeal Reinstatement Policy'))
		{
			$data	=	$this->db->query("select description from requestforms_policy where name='appealforreinstantment'")->row_array();
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getAppealReinstatementPolicy"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getAppealReinstatementPolicy"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAppealReinstatementPolicy"; 
			$this->set_response($response, 200);
		}
	}
*/

//Tbl_AppealReinstatement
    public function appealReinstatement_post()
    {
    	$user_id 	=	$this->post('user_id');
    	$AttendClass 	=	$this->post('AttendClass');
    	$IncompleteGrades 	=	$this->post('IncompleteGrades');
    	$MedicalCondition	=	$this->post('MedicalCondition');
    	$DeathInFamily 	=	$this->post('DeathInFamily');
    	$PersonalCircumstances	=	$this->post('PersonalCircumstances');
    	$Other	=	$this->post('Other');
    	$Documentry	=	$this->post('Documentry');
    	if($user_id!='' && $AttendClass!='' && $IncompleteGrades!='' && $MedicalCondition!='' && $DeathInFamily!='' && $PersonalCircumstances!='' && $Other!='' && $Documentry!='')
    	{
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="appealReinstatement"; 
			$this->set_response($response, 200);
		}
		else{
    		$ins_arr 	=	array('UserID'=>$user_id,
								'AttendClass'=>$AttendClass,
								'IncompleteGrades'=>$IncompleteGrades,
								'MedicalCondition'=>$MedicalCondition,
								'DeathInFamily'=>$DeathInFamily,
								'PersonalCircumstances'=>$PersonalCircumstances,
								'Other'=>$Other,
								'Documentry'=>$Documentry,
								'CreatedBy'=>$user_id);

								$data =	$this->dbConnect('Portal')->insert("Tbl_AppealReinstatement",$ins_arr);

    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="appealReinstatement"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="appealReinstatement"; 
				$this->set_response($response, 200);
    		}
    	}
		}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="appealReinstatement"; 
			$this->set_response($response, 200);
		}
    }

	
    public function CourseWithdrawalCourses_post()
	{
		$user_id =	$this->post('user_id');
		if($user_id!='')
		{
			$this->db1 	=	$this->dbConnect('portal');
			$data=	$this->db1->query("exec SHP_PopulateStudent_ReqestDetails ?,'CourseWithdrawn',0",array($user_id))->result_array();
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCourseWithdrawalCourses"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCourseWithdrawalCourses"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCourseWithdrawalCourses"; 
			$this->set_response($response, 200);
		}
	}

	public function CourseName_post()
	{
		$user_id =	$this->post('user_id');
		$course_id =	$this->post('course_id');
		if($user_id!='' && $course_id!='')
		{
			$this->db1 	=	$this->dbConnect('portal');
			$data=	$this->db1->query("exec SHP_PopulateStudent_ReqestDetails ?,'CourseName',?",array($user_id,$course_id))->row_array();
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCourseName"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCourseName"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCourseName"; 
			$this->set_response($response, 200);
		}
	}

    public function courseWithdrawal_post()
    {
    	$user_id 	=	$this->post('user_id');
    	$CourseCode=	$this->post('CourseCode');
    	$CourseTitle=	$this->post('CourseTitle');
    	$Remarks 		=	$this->post('Remarks');
    	if($user_id!='' && $CourseCode!='' && $CourseTitle!='' && $Remarks!='')
    	{
    	$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="courseWithdrawal"; 
			$this->set_response($response, 200);
		}
		else{
			
			$ins_arr 	=	array('UserID'=>$user_id,
								'CourseCode'=>$CourseCode,
								'CourseTitle'=>$CourseTitle,
								'Remarks'=>$Remarks,
								'CreatedBy'=>$user_id);

								$data =	$this->dbConnect('Portal')->insert("Tbl_CourseWathdrawlForm",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="courseWithdrawal"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="courseWithdrawal"; 
				$this->set_response($response, 200);
    		}
    	}
		}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="courseWithdrawal"; 
			$this->set_response($response, 200);
		}
    }

    public function getStudentPersonalInfo_post()
	{
		$user_id =	$this->post('user_id');
		if($user_id!='')
		{
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="getOnlineRequestTypes"; 
			$this->set_response($response, 200);
		}
		else{
		
			$data=	$this->dbConnect('portal')->query("exec SHP_PopulateStudent_ReqestDetails ?,'PersonelInfo',0",array($user_id))->row_array();
			
			if(count($data)>0)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getStudentPersonalInfo"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getStudentPersonalInfo"; 
				$this->set_response($response, 200);
			}
		}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getStudentPersonalInfo"; 
			$this->set_response($response, 200);
		}
	}

    public function studentPersonalInfo_post()
    {
    	$user_id 		=	$this->post('user_id');
    	$VisaStudent 	=	$this->post('VisaStudent');
    	$Dependent 		=	$this->post('Dependent');
    	$StayingHostel	=	$this->post('StayingHostel');
    	$StudentEmail			=	$this->post('StudentEmail');
    	$StudentMobileNo		=	$this->post('StudentMobileNo');
    	$StudentVisaNo		=	$this->post('StudentVisaNo');
    	$StudentPassportNo	=	$this->post('StudentPassportNo');
    	$StudentEmiratesID	=	$this->post('StudentEmiratesID');
    	$ParentName	=	$this->post('ParentName');
    	$ParentEmirate	=	$this->post('ParentEmirate');
    	$MobileNo	=	$this->post('MobileNo');
    	$Email	=	$this->post('Email');
    	$RecidenceTelNo	=	$this->post('RecidenceTelNo');
    	$ParentWorkPlace	=	$this->post('ParentWorkPlace');
    	$ParentDesignation	=	$this->post('ParentDesignation');
    	$WorkingStudent=	$this->post('WorkingStudent');
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="studentPersonalInfo"; 
			$this->set_response($response, 200);
		}
		else{


	if($user_id!='' && $VisaStudent!='' && $Dependent!='' && $StayingHostel!='' && $StudentEmail!='' && $StudentMobileNo!='' && $StudentVisaNo!='' && $StudentPassportNo!='' && 
	$StudentEmiratesID!='' && $ParentName!='' && $ParentEmirate!='' && $MobileNo!='' && $Email!='' && $RecidenceTelNo!='' && $ParentWorkPlace!='' &&
	 $ParentDesignation!=''  && $WorkingStudent!='')

    	{
    		$ins_arr 	=	array('UserID'=>$user_id,
								'VisaStudent'=>$VisaStudent,
								'Dependent'=>$Dependent,
								'StayingHostel'=>$StayingHostel,
								'StudentEmail'=>$StudentEmail,
								'StudentMobileNo'=>$StudentMobileNo,
								'StudentPassportNo'=>$StudentPassportNo,
								'StudentVisaNo'=>$StudentVisaNo,
								'StudentEmiratesID'=>$StudentEmiratesID,
								'ParentName'=>$ParentName,
								'ParentEmirate'=>$ParentEmirate,
								'MobileNo'=>$MobileNo,
								'Email'=>$Email,
								'RecidenceTelNo'=>$RecidenceTelNo,
								'ParentWorkPlace'=>$ParentWorkPlace,
								'ParentDesignation'=>$ParentDesignation,
								'WorkingStudent'=>$WorkingStudent,
								'CreatedBy'=>$user_id);
								$data =	$this->dbConnect('Portal')->insert("Tbl_StudentPersonalData",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="studentPersonalInfo"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="studentPersonalInfo"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="studentPersonalInfo"; 
			$this->set_response($response, 200);
		}
		}
    }
/*
    public function leaveApplication_post()
    {
    	$user_id=	$this->post('user_id');
    	$from	=	$this->post('from');
    	$to 	=	$this->post('to');
    	$contact_no =	$this->post('contact_no');
    	$mobile_no 	=	$this->post('mobile_no');
    	$document_submitted	=	$this->post('document_submitted');
    	$address_to =	$this->post('address_to');
    	$reason 	=	$this->post('reason');
    	if($user_id!='' && $from!='' && $to!='' && $document_submitted!='' && $address_to!='' && $reason!='' && $this->loghistory('LEAVE APPLICATION'))
    	{
    	if($this->checkDates($from,$to))
    	{	
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="leaveApplication"; 
			$this->set_response($response, 200);
		}
		else{
    		$ins_arr 	=	array('UserID'=>$user_id,
								'LeaveFrom'=>$from,
								'LeaveTo'=>$to,
								'ContactNo'=>$contact_no,
								'MobileNo'=>$mobile_no,
								'DocumentSubmitted'=>$document_submitted,
								'AddressTo'=>$address_to,
								'ReasonForLeave'=>$reason,
								'CreatedBy'=>$user_id);
    		if($this->master_model->insertRecord('Tbl_LeaveApplication',$ins_arr,true))
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="leaveApplication"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="leaveApplication"; 
				$this->set_response($response, 200);
    		}
		}
		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Invalid date selection...From date is greater than to date...!"; 
				$response["command"]="leaveApplication"; 
				$this->set_response($response, 200);
    		}
		}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="leaveApplication"; 
			$this->set_response($response, 200);
		}
    }*/
    /*-----------------------Student Passport Withdrawal-----------------*/
	public function passportWithdrawal_post()
    {
    	$user_id=	$this->post('user_id');
    	$LocalPersonName	=	$this->post('LocalPersonName');
    	$LocalMobileNo 	=	$this->post('LocalMobileNo');
    	$InternationalPersonName	=	$this->post('InternationalPersonName');
    	$InternationalMobileNo =	$this->post('InternationalMobileNo');
    	$ReturnDate 	=	$this->post('ReturnDate');
    	$Reason 	=	$this->post('Reason');
    	if($user_id!='' && $LocalPersonName!='' && $LocalMobileNo!='' && $InternationalPersonName!='' && $InternationalMobileNo!='' && $ReturnDate!='' && $Reason!='')
    	{
    	$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="passportWithdrawal"; 
			$this->set_response($response, 200);
		}
		else{
			$ins_arr 	=	array('Stud_ID'=>$user_id,
								'LocalPersonName'=>$LocalPersonName,
								'LocalMobileNo'=>$LocalMobileNo,
								'InternationalPersonName'=>$InternationalPersonName,
								'InternationalMobileNo'=>$InternationalMobileNo,
								'ReturnDate'=>date('Y-m-d H:i:s',strtotime($ReturnDate)),
								'Reason'=>$Reason,
								'created_by'=>$user_id);

								$data =	$this->dbConnect('Portal')->insert("TblStudent_PassportWithdrawalDetails",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="passportWithdrawal"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="passportWithdrawal"; 
				$this->set_response($response, 200);
    		}
    	}
		}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="passportWithdrawal"; 
			$this->set_response($response, 200);
		}
    }    

    public function GeneralApptCatDeptTime_post()
	{
		$data =  array();
		
			$this->db1 	=	$this->dbConnect('portal');
			$data['category']	=	$this->db1->query("exec SP_GETCASECATEGORY")->result_array();
			

			$this->db1 	=	$this->dbConnect('payroll');
			$data['department']	=	$this->db1->query("exec SHP_ComplaintSuggestion")->result_array();
			
			$data['time']	=	$this->db->query("SELECT timevalue 
												FROM requestforms_generalappointment_time 
												WHERE is_active=1 
												ORDER BY sequence")->result_array();
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getGeneralApptCatDeptTime"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getGeneralApptCatDeptTime"; 
				$this->set_response($response, 200);
			}
		
	}

	public function GeneralApptDate_post()
	{
		$user_id 	=	$this->post('user_id');
		$emp_no 	=	$this->post('emp_no');
		$department =	$this->post('department');
		if($user_id!='' && $emp_no!='' && $department!='')
		{
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"AdminExam", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if( $conn )
			{
				$result = sqlsrv_query($conn,'exec SP_GeneralAppointmentDate ?,?,?',array($user_id,$emp_no,$department)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="getGeneralApptDate"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    if( $next_result ) 
					    {
					        while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
					        {   
					        	$data[] =	$row;	
					        }
					    }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{	
					$response["success"] = "1"; 
					$response["data"] = $data;
					$response["message"] = "";
					$response["command"]="getGeneralApptDate"; 
					$this->set_response($response, 200);
				}
				else
				{
					$response["success"] = "0"; 
					$response["data"] = null; 
					$response["message"] = "Records not found.";
					$response["command"]="getGeneralApptDate"; 
					$this->set_response($response, 200);
				}
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="getGeneralApptDate"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getGeneralApptDate"; 
			$this->set_response($response, 200);
		}
	}
//Tbl_StudentAppointmentDetails
    public function generalAppointment_post()
    {
		$user_id 	=	$this->post('user_id');
		$CATEGORY_ID = $this->post('CATEGORY_ID');
		$CASETYPE_ID	=	$this->post('CASETYPE_ID');
		$EmpNumber =  $this->post('EmpNumber');
		$Department_ID =	$this->post('Department_ID');
    	$AppointMentDate 	=	$this->post('AppointMentDate');
    	$AppointmentTime 	=	$this->post('AppointmentTime');
    	$StudentRemarks=	$this->post('StudentRemarks');
    	if($user_id!='' && $CASETYPE_ID!=''  &&  $EmpNumber!='' && $CATEGORY_ID!='' && $Department_ID!='' && $case_category!='' && $StudentRemarks!='' && $AppointMentDate!=''&& $AppointmentTime!='')
    	{
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="generalAppointment"; 
			$this->set_response($response, 200);
		}
		else{
			$ins_arr 	=	array('Stud_ID'=>$user_id,
								'CATEGORY_ID'=>$CATEGORY_ID,
								'CASETYPE_ID'=>$CASETYPE_ID,
								'EmpNumber'=>$EmpNumber,
								'Department_ID'=>$Department_ID,
								'CaseCategory'=>$case_category,
								'AppointMentDate'=>$AppointMentDate,
								'AppointmentTime'=>$AppointmentTime,
								'StudentRemarks'=>$StudentRemarks);
								$data =	$this->dbConnect('Portal')->insert("Tbl_StudentAppointmentDetails",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="generalAppointment"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="generalAppointment"; 
				$this->set_response($response, 200);
    		}
    	}
	}
	else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="generalAppointment"; 
			$this->set_response($response, 200);
		}
	} 
	

    public function AdvisorNameDateCasedesc_post()
	{
		$user_id =	$this->post('user_id');
		$data =  array();
		if($user_id!='')
		{
			

			$data['case_description']	=	$this->dbConnect('portal')->query("SELECT CATEGORY_ID, CATEGORY_DESCRIPTION  from TBL_SSD_CATEGORY wHERE Status=1")->result_array();
			$data['advisor_name']	=	$this->dbConnect('portal')->query("exec SP_POPULATE_ADVISOR ?",array($user_id))->row_array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"portal", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if( $conn )
			{
				$result = sqlsrv_query($conn,"exec SP_SCHEDURE_ADVISIOR_APPOINTMENT ?,'DATE'",array($user_id)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="getAcademicProfileCourse"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
				        {   
				        	$data['dates'][] 	=	$row;	
				        }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{	
					$response["success"] = "1"; 
					$response["data"] = $data;
					$response["message"] = "";
					$response["command"]="getAdvisorNameDateCasedesc"; 
					$this->set_response($response, 200);
				}
				else
				{
					$response["success"] = "0"; 
					$response["data"] = null; 
					$response["message"] = "Records not found.";
					$response["command"]="getAdvisorNameDateCasedesc"; 
					$this->set_response($response, 200);
				}
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="getAdvisorNameDateCasedesc"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAdvisorNameDateCasedesc"; 
			$this->set_response($response, 200);
		}
	}


	public function AdvisorApptTime_post()
	{
		$user_id 	=	$this->post('user_id');
		$appt_date 	=	$this->post('appt_date');
		if($user_id!='' && $appt_date!='')
		{
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"portal", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if( $conn )
			{
				$result = sqlsrv_query($conn,"exec SP_SCHEDURE_ADVISIOR_APPOINTMENT ?,'TIME',?",array($user_id,$appt_date)); 

				if ($result === FALSE) 
				{
					$response["success"] = "0";
					$response["data"] = null;
					$response["message"] ="Something went wrong."; 
					$response["command"]="getAdvisorApptTime"; 
					$this->set_response($response, 200);
				}
				else
				{
					while($next_result=sqlsrv_next_result($result))
					{
					    while($row = sqlsrv_fetch_array($result,SQLSRV_FETCH_ASSOC))
				        {   
				        	$data[] =	$row;	
				        }
					}
				}
				sqlsrv_close( $conn); 

				if($data)
				{	
					$response["success"] = "1"; 
					$response["data"] = $data;
					$response["message"] = "";
					$response["command"]="getAdvisorApptTime"; 
					$this->set_response($response, 200);
				}
				else
				{
					$response["success"] = "0"; 
					$response["data"] = null; 
					$response["message"] = "Records not found.";
					$response["command"]="getAdvisorApptTime"; 
					$this->set_response($response, 200);
				}
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="getAdvisorApptTime"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAdvisorApptTime"; 
			$this->set_response($response, 200);
		}
	}

	//tb_Advisor_Appoinment_StudentId
    public function advisorAppointment_post()
    {
    	$user_id 	=	$this->post('user_id');
    
    	$AdvisorID	=	$this->post('AdvisorID');
    	$AppoinmentDate 	=	$this->post('AppoinmentDate');
    	$AppoinmentTime 	=	$this->post('AppoinmentTime');
    	$CaseDescription	=	$this->post('CaseDescription');
    	$StudentProblem =	$this->post('StudentProblem');

    	if($user_id!='' && $degree!='' && $AdvisorID!='' && $AppoinmentDate!='' && $AppoinmentTime!='')
    	{
    		$ins_arr 	=	array('Stud_id'=>$user_id,
								'AdvisorID'=>$AdvisorID,
								'AppoinmentDate'=>$AppoinmentDate,
								'AppoinmentTime'=>$AppoinmentTime,
								'CaseDescription'=>$CaseDescription,
								'StudentProblem'=>$StudentProblem);

								$data =	$this->dbConnect('Portal')->insert("tb_Advisor_Appoinment_StudentId",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="advisorAppointment"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="advisorAppointment"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="advisorAppointment"; 
			$this->set_response($response, 200);
		}
    } 	

	//This is static now
	public function PayOnlineLink_post()
	{
		$user_id=  $this->post('user_id');
		$pay_for   =  $this->post('pay_for');
		if($user_id!='' && $pay_for!='')
		{
			$studid = file_get_contents('https://skylineportal.com/report/pages/encdesc.aspx?type=e&text='.$user_id);

			$studid2 = file_get_contents('https://skylineportal.com/report/pages/encdesc.aspx?type=e&text='.$user_id . 'TRUE');
			
			$url="";
			if($pay_for=='onlinerequest')
			{
				$url = "https://payment.skylineuniversity.ac.ae/studentonlinepayment.aspx?studid=". $studid ."&OnlineRequest=".$studid2;
			}

			if($pay_for=='feespayonline')
			{
				$url = "https://payment.skylineuniversity.ac.ae/studentonlinepayment.aspx?studid=".$studid;
			}

			if($url)
			{  
				$response["success"] = "1"; 
				$response["data"] = $url;
				$response["message"] = "";
				$response["command"]="getPayOnlineLink"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getPayOnlineLink"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
		  $response["success"] = "0";
		  $response["data"] = null;
		  $response["message"] ="You didn't provide a required parameter."; 
		  $response["command"]="getPayOnlineLink"; 
		  $this->set_response($response, 200);
		}
	} 

	//This is static now
	public function DownloadLink_post()
	{
		$user_id=  $this->post('user_id');
		$type   =  $this->post('type');
		if($user_id!='' && $type!='')
		{
			
		$cblock = $this->checkBlock($user_id);
		if(!empty($cblock))
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] =$cblock; 
			$response["command"]="getDownloadLink"; 
			$this->set_response($response, 200);
		}else
		{
			$link="";//,invoices, admissionkit
			if($type=='ledger')
			{
				$link="https://skylineportal.com/report/pages/feedownload.aspx?StudId=". $user_id ."&apikey=u73D38934729rkdshfkhsd94rS&&formid=25";
			}

			if($type=='invoices')
			{
				$link = "https://skylineportal.com/tempdownload/updatesoon.pdf";
			}

			if($type=='admissionkit')
			{
				$link="https://skylineportal.com/report/pages/feedownload.aspx?StudId=". $user_id ."&apikey=u73D38934729rkdshfkhsd94rS&&formid=27";
			}

			if($type=='contactlist')
			{
				$link = "https://skylineportal.com/tempdownload/erw234234-sdfssf-34fdfsdf-993kd.xlsx";
			}
			if($type=='graduationplan')
			{
			$this->db1 	=	$this->dbConnect('AdminExam');
		    $sql =	"select stud_regno  from vw_student_info where case when stud_id like '%R%' then ltrim(substring(Stud_ID,8,len(stud_id))) else stud_id end = ? and Stud_Course_Status in ('A','T','F')";
			$result34 =	$this->db1->query($sql,array($user_id))->row_array();
			if($result34)
			{
			$link =  "https://www.skylineportal.com/report/pages/PrintClient.aspx?UName=GraduationProfile&StudRegno=". $result34['stud_regno'] ."&APIKEY=jhdjsahdjashdklasjty786786dfgdfghdf234565jcghjkyuityfg";
			}
			}
			if($link)
			{  
				$response["success"] = "1"; 
				$response["data"] = $link;
				$response["message"] = "";
				$response["command"]="getDownloadLink"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getDownloadLink"; 
				$this->set_response($response, 200);
			}
		}
		}
		else
		{
		  $response["success"] = "0";
		  $response["data"] = null;
		  $response["message"] ="You didn't provide a required parameter."; 
		  $response["command"]="getDownloadLink"; 
		  $this->set_response($response, 200);
		}
	} 	
    /*Student module : END*/

//TODO: I am Here
    /*Faculty module : START*/
    public function CourseAllocationData_post()
	{
		$faculty_id 	=	$this->post('faculty_id');
		if($faculty_id!='')
		{
			$data = array();
			$serverName = DB_HOSTNAME."\MSSQLServer, 1433";
			$connectionInfo = array( "Database"=>"AdminExam", "UID"=>DB_USERNAME, "PWD"=>DB_PASSWPRD);
			$conn = sqlsrv_connect( $serverName, $connectionInfo);

			if( $conn )
			{	
				$courses	=	sqlsrv_query($conn,"exec SHP_sp_CourseAllocationPortal ?",array($faculty_id));
				$morning	=	sqlsrv_query($conn,"exec SHP_FacultySchedule ?",array($faculty_id));
				$evening	=	sqlsrv_query($conn,"exec SHP_FacultySchedule_Evening ?",array($faculty_id));
				$weekend	=	sqlsrv_query($conn,"exec SHP_FacultySchedule_Weekend ?",array($faculty_id));
				$MQP	=	sqlsrv_query($conn,"exec SHP_FacultySchedule_Weekend_MQP ?",array($faculty_id));

				$data['courses']=array();
				$data['morning']=array();
				$data['evening']=array();
				$data['weekend']=array();
				$data['MQP']=array();
				if($courses!==FALSE)
				{
					do{
			        while($row = sqlsrv_fetch_array($courses,SQLSRV_FETCH_ASSOC))
			        {   
			        	$data['courses'][] =$row;	
			        }
			        }while($next_result=sqlsrv_next_result($courses));
				}
				else{	echo "Here";print_r( sqlsrv_errors(SQLSRV_ERR_ALL));exit();}

				if($morning!==FALSE)
				{
					do
					{
				        while($row = sqlsrv_fetch_array($morning,SQLSRV_FETCH_ASSOC))
				        {   
				        	$data['morning'][] =	$row;	
				        }
					}while($next_result=sqlsrv_next_result($morning));
				}

				if($evening!==FALSE)
				{
					do
					{
				        while($row = sqlsrv_fetch_array($evening,SQLSRV_FETCH_ASSOC))
				        {   
				        	$data['evening'][] =	$row;	
				        }
					}while($next_result=sqlsrv_next_result($evening));
				}

				if($weekend!==FALSE)
				{
					do
					{
				        while($row = sqlsrv_fetch_array($weekend,SQLSRV_FETCH_ASSOC))
				        {   
				        	$data['weekend'][] =	$row;	
				        }
					}while($next_result=sqlsrv_next_result($weekend));
				}

				if($MQP!==FALSE)
				{
					do
					{
				        while($row = sqlsrv_fetch_array($MQP,SQLSRV_FETCH_ASSOC))
				        {   
				        	$data['MQP'][] =	$row;	
				        }
					}while($next_result=sqlsrv_next_result($MQP));
				}
				sqlsrv_close( $conn); 

				if($data)
				{	
					$response["success"] = "1"; 
					$response["data"] = $data;
					$response["message"] = "";
					$response["command"]="getCourseAllocationData"; 
					$this->set_response($response, 200);
				}
				else
				{
					$response["success"] = "0"; 
					$response["data"] = null; 
					$response["message"] = "Records not found.";
					$response["command"]="getCourseAllocationData"; 
					$this->set_response($response, 200);
				}
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="Something went wrong."; 
				$response["command"]="getCourseAllocationData"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCourseAllocationData"; 
			$this->set_response($response, 200);
		}
	}

	public function MyAdvisees_post()
	{
		$advisory_id 	=	$this->post('advisory_id');
		if($advisory_id!='' )
		{
			$this->db1 	=	$this->dbConnect('MYFENCE');
			$data =	$this->db1->query("exec Usp_StudentAdvisory_MobileApp ?",array($advisory_id))->result_array();

			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getMyAdvisees"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getMyAdvisees"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getMyAdvisees"; 
			$this->set_response($response, 200);
		}
	}
/*

	public function AdvisorApptDetailsLog_post()
	{
		$advisory_id 	=	$this->post('advisory_id');
		if($advisory_id!='' )
		{
			$this->db1 	=	$this->dbConnect('adminexam');
			$data =	$this->db1->query("exec SP_ADVISORY_COMMUNICATION_DETAILS ?",array($advisory_id))->result_array();

			//---------------------------------------------
				$sql =" select * from (
				 select '1' as id,'1440' as advisorid,'13350' as stud_id, 'test description' as case_desc,'In Progress' as case_status,
				 'test problem' as problem,'test route' as problems_route,'test solution' as solution,'test remarks' as remarks,
				 'test student name' as student_name union
				  select '2' as id,'1440' as advisorid,'13350' as stud_id, 'test description' as case_desc,'In Progress' as case_status,
				 'test problem' as problem,'test route' as problems_route,'test solution' as solution,'test remarks' as remarks,
				 'test student name' as student_name
				 ) result";
				$data =	$this->db1->query($sql,array($advisory_id))->result_array();

			//---------------------------------------------

			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getAdvisorApptDetailsLog"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getAdvisorApptDetailsLog"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getAdvisorApptDetailsLog"; 
			$this->set_response($response, 200);
		}
	}
*/
	public function CDPDetails_post()
	{
		$faculty_id 	=	$this->post('faculty_id');
		if($faculty_id!='')
		{
		
			$data =	$this->dbConnect('adminexam')->query("exec sp_cpdfacutybatchcodeFaculty ?",array($faculty_id))->result_array();

			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCDPDetails"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCDPDetails"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCDPDetails"; 
			$this->set_response($response, 200);
		}
	}
//tb_passportretaining
	public function passportRetaining_post()
    {
    	$Empid 	=	$this->post('Empid');
    	$reason 	=	$this->post('reason');
    	if($Empid!='' &&  $reason!='' && $this->loghistory('Passport Retaining'))
    	{
	    		$ins_arr 	=	array('Empid'=>$Empid,
									'Reason'=>$reason,
									'CreatedBY'=>$Empid);
									$data =	$this->dbConnect('Payroll')->insert("tb_passportretaining",$ins_arr);

	    		if($data)
	    		{
	    			$response["success"] = "1";
					$response["data"]= null; 
					$response["message"] ="Your request submitted successfully."; 
					$response["command"]="passportRetaining"; 
					$this->set_response($response, 200);
	    		}
	    		else
	    		{
	    			$response["success"] = "0";
					$response["data"]= null; 
					$response["message"] ="Something went wrong please try again."; 
					$response["command"]="passportRetaining"; 
					$this->set_response($response, 200);
	    		}
	    	
	    
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="passportRetaining"; 
			$this->set_response($response, 200);
		}
    } 

    public function SalaryPurposeTypeAndCountry_post()
	{
		
			$data =	array();
			$this->db1 	=	$this->dbConnect('payroll');
			$data['purpose_types'] =	$this->db1->query("exec SP_HR_SALARYPURPOSE_TYPE")->result_array();
			$data['country'] =	$this->db->query("SELECT id,country
												  FROM admission_country
												  WHERE is_active=1
												  ORDER BY CASE WHEN country = 'UAE' THEN 1 ELSE 2 END, country")->result_array();

			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getSalaryPurposeType"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getSalaryPurposeType"; 
				$this->set_response($response, 200);
			}
		
	}

    public function salaryCertificateApplication_post()
    {
    	$empid 	=	$this->post('empid');
    
    	$PurposeID=	$this->post('PurposeID');
    	$Others 	=	$this->post('Others');
    	$address =	$this->post('address');
    	$City 	=	$this->post('City');
    	$Country 		=	$this->post('Country');
 

    	if($empid!=''  && $PurposeID!='' && $address!='' && $City!='' && $Country!='')
    	{
    		$ins_arr 	=	array('empid'=>$empid,
								
								'PurposeID'=>$PurposeID,
								'Others'=>$Others,
								'address'=>$address,
								'City'=>$City,
								'Country'=>$Country,
								'CreatedBy'=>$empid);
								$data =	$this->dbConnect('Payroll')->insert("tbl_salarycertificate",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="salaryCertificateApplication"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="salaryCertificateApplication"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="salaryCertificateApplication"; 
			$this->set_response($response, 200);
		}
    }
	/*-------------------------Faculty/Staff Passport withdrawal form------------------------*/
	
	//LMS_PassportWithdrawl

	//TODO: Try it
    public function passportWithdrawalForm_post()
    {
    	$EmpNumber 	=					$this->post('EmpNumber');
		$LoginIp	=					$this->post('LoginIp');
		$ContactInternationalPerson  =  $this->post('ContactInternationalPerson ');
    	$ContactLocalNo 	=			$this->post('ContactLocalNo');
    	$ContactInternationalNo	=		$this->post('ContactInternationalNo');
    	$ContactLocalPerson 	=		$this->post('ContactLocalPerson');
    	$DateToReturn 	=				$this->post('DateToReturn');
    	$REASON 	=					$this->post('REASON');
    	if($EmpNumber !='' && $usertype!='' && $local_person!='' && $ContactInternationalPerson !='' && $ContactLocalNo!='' && $ContactInternationalNo!='' && $ContactLocalPerson!='' && $DateToReturn!='' && $REASON!='')
    	{
    		$ins_arr 	=	array('EmpNumber'=>$EmpNumber,
								'LoginIp'=>$LoginIp,
								'DateToReturn'=>date('Y-m-d H:i:s',strtotime($DateToReturn)),
								'Reason'=>$REASON,
								'ContactLocalNo'=>$ContactLocalNo,
								'ContactInternationalNo'=>$ContactInternationalNo,
								'ContactLocalPerson'=>$ContactLocalPerson,
								'ContactInternationalPerson '=>$ContactInternationalPerson
								);

								$data =	$this->dbConnect('Payroll')->query("exec LMS_PassportWithdrawl ?,?,?,?,?,?,?,? ",array($EmpNumber,$LoginIp,$DateToReturn,$REASON,$ContactLocalNo,$ContactInternationalNo,$ContactLocalPerson,$ContactInternationalPerson))->result_array();


								
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= $data; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="passportWithdrawalForm"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="passportWithdrawalForm"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="passportWithdrawalForm"; 
			$this->set_response($response, 200);
		}
    }  
//SP_LMS_INSERT_PERMISSION_TO_LEAVESTATION
    public function leaveDuringHolidays_post()
    {
    	$EmpNumber 	=	$this->post('EmpNumber');
    	$from	=	$this->post('from');
		$to 	=	$this->post('to');
		$LoginIp = $this->post('LoginIp');
    	$AddressWhileOnLeave =	$this->post('AddressWhileOnLeave');
    	$ReasonForTravel 	=	$this->post('ReasonForTravel');
    	$name 	=	$this->post('name');
    	$email 	=	$this->post('email');
    	$relationship=	$this->post('relationship');
    	$mobile_no	=	$this->post('mobile_no');
    	$residance_no	=	$this->post('residance_no');
    	$office_no	=	$this->post('office_no');
    	$address	=	$this->post('address');

    	if($EmpNumber!=''  &&  $from!='' && $to!='' && $AddressWhileOnLeave!='' && $Relationship !='' && $ReasonForTravel!='' && $address!='')
    	{
    		
    		if($this->checkDates($from,$to))
    		{
    		$ins_arr 	=	array('EmpNumber'=>$EmpNumber,
    						'LoginIp'=>$LoginIp,
								'LeaveFrom'=>$from,
								'LeaveTo'=>$to,
								'AddressWhileOnLeave'=>$AddressWhileOnLeave,
								'ReasonForTravel'=>$ReasonForTravel,
								'Name'=>$name,
								'Email'=>$email,
								'Relationship'=>$relationship,
								'MobileNo'=>$mobile_no,
								'TelephoneNoResidence'=>$residance_no,
								'TelephoneNoOffice'=>$office_no,
								'Address'=>$address,
								'CreatedBy'=>$EmpNumber);

								$data=	$this->dbConnect('Payroll')->query("exec SP_LMS_INSERT_PERMISSION_TO_LEAVESTATION ?,?,?,?,?,?,?,?,?,?,?,?,?,?",array($EmpNumber,$ReasonForTravel,$LoginIp,$from,
								$to,$AddressWhileOnLeave,$relationship,$name,$address,$mobile_no,$residance_no,$office_no,$email))->row_array();

			if($data)			

    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="leaveDuringHolidays"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="leaveDuringHolidays"; 
				$this->set_response($response, 200);
    		}

    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Invalid date selection...From date is greater than to date...!"; 
				$response["command"]="leaveApplication"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="leaveDuringHolidays"; 
			$this->set_response($response, 200);
		}
    }

    public function LeaveTypes_post()
	{
		$Empid =	$this->post('Empid');
		if($Empid!='')
		{
			$this->db1 	=	$this->dbConnect('payroll');
			$data =	$this->db1->query("exec SHP_Leave_Details_Populate ?",array($Empid))->result_array();
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getLeaveTypes"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getLeaveTypes"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getLeaveTypes"; 
			$this->set_response($response, 200);
		}
	}
//TODO: not complated
	public function LeaveTypeBalance_post()
	{
		$Empid =	$this->post('Empid');
		$leaveid =	$this->post('leaveid');
		if($Empid!='' && $leaveid!='' )
		{
			$this->db1 	=	$this->dbConnect('payroll');
			$data =	$this->db1->query("exec GET_LEAVE_HISTORY_IDWISE_MOBILEAPP ?,?",array($Empid,$leaveid))->row_array();
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getLeaveTypeBalance"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getLeaveTypeBalance"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getLeaveTypeBalance"; 
			$this->set_response($response, 200);
		}
	}
//HR_APPLIED_LEAVE
//TODO: not complate 
	public function facultyStaffleaveApplication_post()
    {
    	$user_id 	=	$this->post('user_id');
    	$usertype 	=	$this->post('usertype');
    	$leave_type	=	$this->post('leave_type');
    	$leave_balance	=	$this->post('leave_balance');
    	$address_to =	$this->post('address_to');
    	$contact_no	=	$this->post('contact_no');
    	$from		=	$this->post('from');
    	$to 		=	$this->post('to');
    	$half_day	=	$this->post('half_day');
    	$half_day_session	=	$this->post('half_day_session');
    	$leave_days	=	$this->post('leave_days');
    	$lwp 		=	$this->post('lwp');
    	$reason 	=	$this->post('reason');
    	$half_day_date = $forwarded_to=	"";

    

    	if($user_id!='' && $usertype!='' &&  $leave_type!='' &&  $leave_balance!='' &&  $from!='' && $to!='' && $address_to!='' && $contact_no!='' && $half_day!='' && $leave_days!='' && $lwp!='' && $reason!='')
    	{
    		if($this->checkDates($from,$to))
    		{
    		$this->db1 	=	$this->dbConnect('Payroll');
			$data =	$this->db1->query("exec sp_employeeapprover ?",array($user_id))->row_array();
			if($data){	$forwarded_to=$data['PersonId'];}

    		if($half_day==1){	$half_day_date 	=	$from;	}
    		$ins_arr 	=	array('UserID'=>$user_id,
    							'UserType'=>$usertype,
								'LeaveType'=>$leave_type,
								'LeaveBalance'=>$leave_balance,
								'ForwardedTo'=>$forwarded_to,
								'AddressWhileOnLeave'=>$address_to,
								'UAEContactNo'=>$contact_no,
								'LeaveFrom'=>$from,
								'LeaveTo'=>$to,
								'halfdaydate'=>$half_day_date,
								'HalfDay'=>$half_day,
								'HalfDaySession'=>$half_day_session,
								'LeaveDays'=>$leave_days,
								'LWP'=>$lwp,
								'ReasonForLeave'=>$reason,
								'CreatedBy'=>$user_id);

								
    		if($this->master_model->insertRecord('Tbl_FacultyStaffLeaveApplication',$ins_arr,true))
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="facultyStaffleaveApplication"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="facultyStaffleaveApplication"; 
				$this->set_response($response, 200);
    		}
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Invalid date selection...From date is greater than to date...!"; 
				$response["command"]="leaveApplication"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="facultyStaffleaveApplication"; 
			$this->set_response($response, 200);
		}
    }

    public function PersonalFamilyTimes_post()
	{
		$emp_id =	$this->post('emp_id');
		if($emp_id!='')
		{
			$data=array();
			$this->db1 	=	$this->dbConnect('payroll');
			$data['personal'] =	$this->db1->query("SELECT EmpNumber,title,name FROM Viewperson WHERE EmpNumber = ?",array($emp_id))->result_array();
			$data['family'] =	$this->db1->query("exec sp_airlineticketapplication ?",array($emp_id))->result_array();
			$data['times'] =	$this->master_model->getRecords('master_airticket_time',array('is_active'=>1),'time_value');

			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getPersonalFamilyTimes"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getPersonalFamilyTimes"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getPersonalFamilyTimes"; 
			$this->set_response($response, 200);
		}
	}
	
	//Not Done
	public function airlineTicketReimbursement_post()
    {
    	$user_id 	=	$this->post('user_id');
    	$usertype 	=	$this->post('usertype');
    	$self 		=	json_decode($this->post('self'),true);
    	$family		=	json_decode($this->post('family'),true);
    	$remark 	=	$this->post('remark');
    	$forwarded_to=	$AID =	"";

    	if($user_id!='' && $usertype!='' &&  count($self)>0 &&  $remark!='')
    	{
    		$this->db1 	=	$this->dbConnect('Payroll');
			$data =	$this->db1->query("exec sp_employeeapprover ?",array($user_id))->row_array();
			if($data){	$forwarded_to=$data['PersonId'];}


			$this->db->trans_begin();
    		
    		if(count($self)>0)
    		{
    			foreach ($self as $row) {
    				$ins_arr 	=	array('UserID'=>$user_id,
										'UserType'=>$usertype,
										'LeaveFrom'=>$row['fromdate'],
										'LeaveTo'=>$row['todate'],
										'PlaceFrom'=>$row['fromcity'],
										'PlaceFrom1'=>$row['fromcity1'],
										'PlaceTo'=>$row['tocity'],
										'PlaceTo1'=>$row['tocity1'],
										'ForwardedTo'=>$forwarded_to,
										'Day'=>date('l',strtotime($row['fromdate'])),
										'Day1'=>date('l',strtotime($row['todate'])),
										'Time'=>$row['time'],
										'Time1'=>$row['time1'],
										'Remarks'=>$remark,
										'CreatedBy'=>$user_id);		
    				$AID 	=	$this->master_model->insertRecord('Tbl_AirticketRequest',$ins_arr,true);
    			}
    		}

    		// if(count($self)>0)
    		// {
    		// 	foreach ($self as $row) {
    		// 		$ins_arr 	=	array('empid'=>$row['empid'],
			// 							'familyid'=>$row['familyid'],
			// 							'AID'=>$AID,
			// 							'fromdate'=>$row['fromdate'],
			// 							'todate'=>$row['todate'],
			// 							'fromcity'=>$row['fromcity'],
			// 							'tocity'=>$row['tocity'],
			// 							'fromcity1'=>$row['fromcity1'],
			// 							'tocity1'=>$row['tocity1'],
			// 							'day'=>date('l',strtotime($row['fromdate'])),
			// 							'day1'=>date('l',strtotime($row['todate'])),
			// 							'time'=>$row['time'],
			// 							'time1'=>$row['time1']);		
    		// 		$this->master_model->insertRecord('Tbl_TicketApplicationFamily',$ins_arr);
    		// 	}
    		// }

    		if(count($family)>0)
    		{
    			foreach ($family as $row) {
    				$ins_arr 	=	array('empid'=>$row['empid'],
										'familyid'=>$row['familyid'],
										'AID'=>$AID,
										'fromdate'=>$row['fromdate'],
										'todate'=>$row['todate'],
										'fromcity'=>$row['fromcity'],
										'tocity'=>$row['tocity'],
										'fromcity1'=>$row['fromcity1'],
										'tocity1'=>$row['tocity1'],
										'day'=>date('l',strtotime($row['fromdate'])),
										'day1'=>date('l',strtotime($row['todate'])),
										'time'=>$row['time'],
										'time1'=>$row['time1']);	
    				$this->master_model->insertRecord('Tbl_TicketApplicationFamily',$ins_arr);
    			}
    		}

    		if($this->db->trans_status() === FALSE)
    		{
    			$this->db->trans_rollback();
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="airlineTicketReimbursement"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$this->db->trans_commit();
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="airlineTicketReimbursement"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="airlineTicketReimbursement"; 
			$this->set_response($response, 200);
		}
    }

    public function LibraryMaterial_post()
	{
		
			$this->db1 	=	$this->dbConnect('Portal');
			$data =	$this->db1->query("exec SP_library_Material")->result_array();
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getLibraryMaterial"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getLibraryMaterial"; 
				$this->set_response($response, 200);
			}
	
	}
//Tbl_LibraryBookRequisition
	public function libraryBookRequisition_post()
    {
    	$user_id 	=	$this->post('UserID');
    	$UserName 	=	$this->post('UserName');
    	$title		=	$this->post('title');
    	$author 	=	$this->post('author');
    	$edition	=	$this->post('edition');
    	$publisher 	=	$this->post('publisher');
    	$year 		=	$this->post('year');
    	$isbn_no 	=	$this->post('isbn_no');
    	$quantity 	=	$this->post('quantity');
    	$price 		=	$this->post('price');
    	$type_of_material 	=	$this->post('type_of_material');

    	if($user_id!='' && $UserName!='' && $title!='' && $author!='' && $edition!='' && $publisher!='' && $year!='' && $isbn_no!='' && $quantity!='' && $price!='' && $type_of_material!='')
    	{
    		$ins_arr 	=	array('UserID'=>$user_id,
								'UserName'=>$UserName,
								'Title'=>$title,
								'Author'=>$author,
								'Edition'=>$edition,
								'Publisher'=>$publisher,
								'Year'=>$year,
								'IsbnNo'=>$isbn_no,
								'Quantity'=>$quantity,
								'UnitPrice'=>$price,
								'TypeofMaterial'=>$type_of_material);

								$data =	$this->dbConnect('DB_SharePointPortal')->insert("Tbl_LibraryBookRequisition",$ins_arr);
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="libraryBookRequisition"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="libraryBookRequisition"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="libraryBookRequisition"; 
			$this->set_response($response, 200);
		}
    } 	
/*
    public function gCalendarTabsByType_post()
	{
		$type = $this->post('type');
		if($type!='' && $this->loghistory('Get calendar tabs by type'))
		{
			$data =	$this->master_model->getRecords('master_calendartype',array('is_active'=>1,'type'=>$type),'id,tabname',array('sequence'=>'ASC'));
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCalendarTabsByType"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCalendarTabsByType"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCalendarTabsByType"; 
			$this->set_response($response, 200);
		}
	}

	public function getCalendarDetails_post()
	{
		$id =	$this->post('id');
		if($id!='' && $this->loghistory('Get Calendar Details'))
		{
			$data = array();
			$result 	=	$this->master_model->getRecord('master_calendartype',array('id'=>$id),'filtervalue');
			if($result)
			{
				$this->db1 	=	$this->dbConnect('DB_SkylineCalendarEvents');
				$this->db1->like('category1',$result['filtervalue']);
				$this->db1->order_by('eventstartdt','ASC');
				$data =	$this->db1->get("VW_Calendar_DATA")->result_array();
			}
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCalendarDetails"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCalendarDetails"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCalendarDetails"; 
			$this->set_response($response, 200);
		}
	}

	public function getCalendarDownloads_post()
	{
		$type =	$this->post('type');
		if($type!='' && $this->loghistory('Get Calendar Downloads'))
		{
			$data 	=	$this->master_model->getRecords('calendar_downloads',array('type'=>$type),'title,path');
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getCalendarDownloads"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getCalendarDownloads"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getCalendarDownloads"; 
			$this->set_response($response, 200);
		}
	}

	public function getMembershipFormRelations_post()
	{
		if($this->loghistory('Get Membership Form Relations'))
		{


			$data =	$this->master_model->getRecords('master_relations','','name',array('sequence'=>'ASC'));
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getMembershipFormRelations"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getMembershipFormRelations"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getMembershipFormRelations"; 
			$this->set_response($response, 200);
		}
	}
*/
//TODO: i didnt find it 
/*
	public function membershipForm_post()
    {
    	$user_id 	=	$this->post('user_id');
    	$usertype 	=	$this->post('usertype');
    	$name 		=	$this->post('name');
    	$gender		=	$this->post('gender');
    	$relation 	=	$this->post('relation');
    	$address	=	$this->post('address');
    	$contact_home 	=	$this->post('contact_home');
    	$contact_work 	=	$this->post('contact_work');
    	$contact_mobile =	$this->post('contact_mobile');
    	$forwarded_to 	= "";
    	if($user_id!='' && $name!='' && $gender!='' && $relation!='' && $address!='' && $contact_home!='' && $contact_work!='' && $contact_mobile!='' && $this->loghistory('Library Membership Form'))
    	{
    		$this->db1 	=	$this->dbConnect('Payroll');
			$data =	$this->db1->query("exec sp_employeeapprover ?",array($user_id))->row_array();
			if($data){	$forwarded_to=$data['PersonId'];}

    		$ins_arr 	=	array('UserID'=>$user_id,
								'UserType'=>$usertype,
								'Name'=>$name,
								'Gender'=>$gender,
								'Relationship'=>$relation,
								'ResidentialAddress'=>$address,
								'Contact_Home'=>$contact_home,
								'Contact_Work'=>$contact_work,
								'Contact_Mobile'=>$contact_mobile,
								'ForwardedTo'=>$forwarded_to,
								'CreatedBY'=>$user_id);
    		if($this->master_model->insertRecord('Tbl_MembershipForm',$ins_arr,true))
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="membershipForm"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="membershipForm"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="membershipForm"; 
			$this->set_response($response, 200);
		}
    } 
*/

    public function OutdoorEventTime_post()
	{
		
			$data =	$this->master_model->getRecords('outdoor_event_time','','time_text',array('sequence'=>'ASC'));
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getOutdoorEventTime"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Records not found.";
				$response["command"]="getOutdoorEventTime"; 
				$this->set_response($response, 200);
			}
		
	}

	//LMS_INSERTOutDoorEvents
	public function outdoorEvent_post()
    {
    	$EmpNumber 	=	$this->post('EmpNumber');
    	$LoginIp	=	$this->post('LoginIp');
    	$Eventdate =	$this->post('Eventdate');
    	$Fromtime	=	$this->post('Fromtime');
    	$ToTime 	=	$this->post('ToTime');
    	$EventName	=	$this->post('EventName');
    	$halfday 	=	$this->post('halfday');
    	$reason 	=	$this->post('reason');
		$Shift 		=	$this->post('Shift');
		$Days 		= 	$this->post('Days');

    	if($EmpNumber!='' && $Eventdate!='' &&$LoginIp!=''&& $Fromtime!='' && $ToTime!='' && $EventName!='' && $halfday!='' && $reason!='' && $Shift!='' && $Days!='')
    	{
    		$ins_arr 	=	array('EmpNumber'=>$EmpNumber,
								'LoginIp'=>$LoginIp,
								'Eventdate'=>$Eventdate,
								'Fromtime'=>$Fromtime,
								'ToTime'=>$ToTime,
								'EventName'=>$EventName,
								'halfday'=>$halfday,
								'REASON'=>$reason,
								'Shift'=>$Shift,
								'Days'=>$Days,
								'CreatedBy'=>$EmpNumber);
								$data =	$this->dbConnect('Payroll')->query("exec LMS_INSERTOutDoorEvents ?,?,?,?,?,?,?,?,?,?",array($EmpNumber,$LoginIp,$Eventdate,$Fromtime,$ToTime,$EventName,$halfday,$reason,$Shift,$Days))->row_array();
							
    		if($data)
    		{
    			$response["success"] = "1";
				$response["data"]= null; 
				$response["message"] ="Your request submitted successfully."; 
				$response["command"]="outdoorEvent"; 
				$this->set_response($response, 200);
    		}
    		else
    		{
    			$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="outdoorEvent"; 
				$this->set_response($response, 200);
    		}
    	}
		else
		{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="outdoorEvent"; 
			$this->set_response($response, 200);
		}
    } 
//TODO: Not finished
	
    public function getDataByType_post()
	{
		$type 	= 	$this->post('type');
		$user_id= 	$this->post('user_id');
		if($type!='' && $user_id!='')
		{
			$data = array();
			
			if($type=='circular'){
				$data	=	$this->db->query("select id,title,(tuip.linkname+tuip.foldername+path) as path,published_datetime from circular,Tbl_DocImage_Path tuip where level3='CIRCULARS' and is_active=1 and tuip.type='doc' and title not like '%.zip' order by published_datetime desc")->result_array();
			}
			
			if($data)
			{	
				$response["success"] = "1"; 
				$response["data"] = $data;
				$response["message"] = "";
				$response["command"]="getDataByType"; 
				$this->set_response($response, 200);
			}
			else
			{
				$response["success"] = "0"; 
				$response["data"] = null; 
				$response["message"] = "Information will be available soon...!";
				$response["command"]="getDataByType"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
			$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didn't provide a required parameter."; 
			$response["command"]="getDataByType"; 
			$this->set_response($response, 200);
		}
	}
/*
	public function sendNotification_post()
    {
		$user_id	=	$this->post('user_id');
		$usertype	=	$this->post('usertype');
		$title		=	$this->post('title');
		$message	=	$this->post('message');
		$sender	=	$this->post('sender');
		$published_date	=	$this->post('published_date');
		$token	=	$this->post('token');
		if($token=="8sA892731S1xAP2x#x!pS")
		{
			if($user_id!= '' && $usertype!= '' && $title!= '' && $message!= '')
			{
						
			if($user_id==0){
			//------------- For Common Message to be displayed for guestuser
			
			$insArrayC =	array('title' => $title,
							'description' => $message,
			                'published_datetime' => $published_date,
			                'type' => $usertype,
			                'user_id' => $user_id,
			                'created_by' => $sender);
			$this->master_model->insertRecord('notifications',$insArrayC,true);
			
			//------------- ************************************************
			$sql =	"select distinct deviceid from guestusers where deviceid not in (select distinct deviceid from loghistory where activity like 'Login user%')";
			$result23 =	$this->db->query($sql)->result_array();
			$testnotification="";
			foreach ($result23 as $row) {
					$ins_arr 	=	array('title'=>$title,
								'description'=>$message,
								'published_datetime'=>$published_date,
								'device_id'=>$row['deviceid'],
								'user_id'=>'1',
								'created_by'=>$sender);
					if($this->master_model->insertRecord('notifications',$ins_arr,true))
					{
						$sql24 =	"select top 1 devicetoken from guestusers where deviceid='". $row['deviceid'] ."' order by id desc";
						$result24 =	$this->db->query($sql24)->row_array();
						if(!empty($result24['devicetoken'])){
							if(is_numeric(strpos($row['deviceid'],'-')))
							{
								// IOS Push
								//$this->push->ios(array('title'=>$title,'message'=>$message),$result24['devicetoken']);
								$testnotification .= "*****---------IOS--". $row['deviceid'];
							}else
							{
								//Android Push
								//$this->push->android(array('title'=>$title,'message'=>$message),array($result24['devicetoken']));
								$testnotification .= "*****---------ANDROID--". $row['deviceid'];
							}
						}
					}
			}
				$response["success"] = "1"; 
				$response["data"] = count($result23);
				$response["message"] = "Notification send successfully.--". $testnotification;
				$response["command"]="sendNotification"; 
				$this->set_response($response, 200);
			}else{

						//$userInfo[]=array('devicetype'=>'i','devicetoken'=>'0F88D5AE24CADA9F04FB6D9B7BBE90D070798B3906738546179972521F8C61C1');
						//$userInfo[]=array('devicetype'=>'i','devicetoken'=>'F905EF55E71EF7A1C514351D5349E65CE96C821E50386B78930DB2A5A8C10E57');
						$userInfo	=	$this->master_model->getRecord('user_login',array('user_id'=>$user_id,'usertype'=>$usertype,'CONVERT(VARCHAR, devicetoken) <>'=>''),'devicetype,devicetoken');

						
						$insArrayC =	array('title' => $title,
										'description' => $message,
						                'published_datetime' => $published_date,
						                'type' => $usertype,
						                'user_id' => $user_id,
						                'created_by' => $sender);
						$this->master_model->insertRecord('notifications',$insArrayC,true);

						if($userInfo)
						{
							if($userInfo['devicetype']=='i' && $userInfo['devicetoken']!=''){
								$this->push->ios(array('title'=>$title,'message'=>$message),$userInfo['devicetoken']);
							}else if($userInfo['devicetoken']!=''){
								$this->push->android(array('title'=>$title,'message'=>$message),array($userInfo['devicetoken']));
							}

							$response["success"] = "1"; 
							$response["data"] = null;
							$response["message"] = "Notification send successfully. v3";
							$response["command"]="sendNotification"; 
							$this->set_response($response, 200);
						}
						else
						{
							$response["success"] = "0"; 
							$response["data"] = null;
							$response["message"] = "User details not found.";
							$response["command"]="sendNotification"; 
							$this->set_response($response, 200);
						}
					}
			}
			else
			{
				$response["success"] = "0";
				$response["data"] = null;
				$response["message"] ="You didn't provide a required parameter."; 
				$response["command"]="sendNotification"; 
				$this->set_response($response, 200);
			}
		}
		else
		{
		  		$response["message"] ="Invalid Request..."; 
				$this->set_response($response, 200);
		}
    }
*/

	public function checkBlock($userID){
	  //$userID = $this->post('user_id');
	  $this->db1 	=	$this->dbConnect('portal');
	  $text =	$this->db1->query("exec SHP_Portal_Block ?",array($userID))->row_array();
	  $message = null;

	  if(empty($text['NAME'])){
	  	return $message;
	  	//return "There is a block from test";
	  }else
	  {
	  	$message = "There is a block from ". $text['NAME'] . " [ ". $text['DESIGNATION'] ." ] in the deparment ". $text['DEPARTMENT NAME'] .". Please contact";
	  	return $message;
	  }
	}
	
	public function checkOnlineRequestBlock($userID){
	  $userIDT =$userID;
	  $this->db1 	=	$this->dbConnect('portal');
	  $text =	$this->db1->query("exec SP_GetStudentData_Payment_New ?",array($userIDT))->row_array();
	  $message = $text['MessageContent'];
	  $result123 = $text['Result'];
	  if($result123=='False')
	  {
	  	return $message;
	  	
	  }else
	  {
	  	return "";
	  }
	}
	public function checkDates($fromDate,$toDate){
	 	$from = $fromDate;
		$to = $toDate;
		if (strtotime($from) > strtotime($to)) {
		    return "0"; #$date occurs in the future
		} else {
		    return "1";
		}
	}
	/*
	public function guestuser_post()
	{
		$ipaddress		=	$this->post('ipaddress');
		$deviceid		=	$this->post('deviceid');
		$devicename		=	$this->post('devicename');
		$devicetoken=	$this->post('devicetoken');
		if($ipaddress!='' && $deviceid!='' && $devicename!='' && $devicetoken!=''){

		$ins_arr = array('ipaddress'=>$ipaddress,
						'deviceid'=>$deviceid,
						'devicetoken'=>$devicetoken,
						'devicename'=>$devicename);

										$data =	$this->dbConnect('Portal')->insert("GuestUsers",$ins_arr);
		if($data){
				$response["success"] = "1"; 
				$response["data"] = null; 
				$response["message"] = "Done";
				$response["command"]="guestuser"; 
				$this->set_response($response, 200);
		}
		else{
				$response["success"] = "0";
				$response["data"]= null; 
				$response["message"] ="Something went wrong please try again."; 
				$response["command"]="outdoorEvent"; 
				$this->set_response($response, 200);
										
		}
		
	}
}
*/
/*
public function usersMobileApp_post()
{
	$username		=	$this->post('username');
	$password		=	$this->post('password');
	$usertype		=	$this->post('usertype');
	$ipaddress				=	$this->post('ipaddress');
	$location		=	$this->post('location');
	$token 			=   $this->post('token');
	$deviceId		= $this->post('deviceId');
	

	if($username!='' && $ipaddress!=''  && $location!='' && $password!='' && $usertype!='' && $token!='' && $deviceId!=''){
	$ins_arr = array('username'=>$username,
					'password'=>$password,
					'ipaddress'=>$ipaddress,
					'location'=>$location,
					'token'=>$token,
					'deviceId'=>$deviceId,
					'usertype'=>$usertype);

									$data =	$this->dbConnect('Portal')->insert("UsersMobileApp",$ins_arr);
	if($data){
			$response["success"] = "1"; 
			$response["data"] = null; 
			$response["message"] = "Done";
			$response["command"]="usersMobileApp"; 
			$this->set_response($response, 200);
	}
	else{
			$response["success"] = "0";
			$response["data"]= null; 
			$response["message"] ="Something went wrong please try again."; 
			$response["command"]="usersMobileApp"; 
			$this->set_response($response, 200);
									
	}
	
}
else{
		$response["success"] = "0";
			$response["data"] = null;
			$response["message"] ="You didnt provide the parameter"; 
			$response["command"]="usersMobileApp"; 
			$this->set_response($response, 200);

}
}
*/
	public function getImageST($userID,$type)
	{
	 	$sql =	"SELECT distinct (tuip.foldername + '/' +RandomID) as imagepath FROM Tbl_UserImage,Tbl_UserImage_Path tuip where userid=?";
		$result23 =	$this->db->query($sql,array($userID))->row_array();
			if($result23)
			{
			return "https://skylineportal.com/sitgmioxg/" . $result23['imagepath'] . ".JPEG";
			} 
			else if ($type=="STUDENT")
			{
			return "https://skylineportal.com/sitgmioxg/student.jpg";
			}
			else
			{
			return "https://skylineportal.com/sitgmioxg/professor.png";
			}
	}

}

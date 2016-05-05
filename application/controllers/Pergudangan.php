<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Pergudangan extends CI_Controller {
		
	public function index() {	
		$this->CI =& get_instance();	

		$this->simple_login->cek_login();
		$data["user"] = $this->CI->session->userdata('user_operator');
		$data["content_view"] = "admin/pergudangan";
		$this->load->view('admin/template',$data);	
	}
		
}
<?php if(! defined('BASEPATH')) exit('Akses langsung tidak diperbolehkan'); 

class Simple_login {
	// SET SUPER GLOBAL
	var $CI = NULL;
	public function __construct() {
		$this->CI =& get_instance();
	}
	// Fungsi login
	public function login($username, $password) {
		$query = $this->CI->db->get_where('operator',array('user_operator'=>$username,'pass_operator' => md5($password)));
		$JENIS_OPERATOR = $this->CI->db->select('JENIS_OPERATOR')
                  ->get_where('operator', array('user_operator' => $username))
                  ->row()
                  ->JENIS_OPERATOR;
		if($query->num_rows() == 1 && $JENIS_OPERATOR == "0") {
			$row 	= $this->CI->db->query('SELECT ID_OPERATOR FROM operator where user_operator = "'.$username.'"');
			$admin 	= $row->row();
			$id 	= $admin->ID_OPERATOR;
			$this->CI->session->set_userdata('user_operator', $username);
			$this->CI->session->set_userdata('id_login', uniqid(rand()));
			$this->CI->session->set_userdata('id', $id);
			redirect(base_url('index.php/Managment'));
		}else{
			$this->CI->session->set_flashdata('sukses','Username/Password salah');
			redirect(base_url('index.php/Login'));
		}
		return false;
	}
	// Proteksi halaman
	public function cek_login() {
		if($this->CI->session->userdata('user_operator') == '') {
			$this->CI->session->set_flashdata('sukses','Anda belum login');
			redirect(base_url('index.php/Login'));
		}
	}
	public function cek_sudah_login() {
		if($this->CI->session->userdata('user_operator') != '') {
			$this->CI->session->set_flashdata('sukses','Anda belum login');
			redirect(base_url('index.php/Login'));
		}
	}
	// Fungsi logout
	public function logout() {
		$this->CI->session->unset_userdata('user_operator');
		$this->CI->session->unset_userdata('id_login');
		$this->CI->session->unset_userdata('id');
		$this->CI->session->set_flashdata('sukses','Anda berhasil logout');
		redirect(base_url('index.php/Login'));
	}
}

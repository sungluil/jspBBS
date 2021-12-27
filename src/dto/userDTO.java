package dto;

/*
이름         널?       유형            
---------- -------- ------------- 
ID         NOT NULL VARCHAR2(100) 
PW                  VARCHAR2(100) 
EMAIL               VARCHAR2(100) 
LAST_LOGIN          VARCHAR2(100) 
*/

public class userDTO {
	private String id;
	private String pw;
	private String name;
	private String email;
	private String lastLogin;

	public userDTO() {
		// TODO Auto-generated constructor stub
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(String lastLogin) {
		this.lastLogin = lastLogin;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}

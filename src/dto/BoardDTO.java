package dto;

/*
�대�        ��?       ����             
--------- -------- -------------- 
NUM       NOT NULL NUMBER(4)      - 寃���湲� 踰���(怨���媛�) : ����利�媛�媛�   
ID                 VARCHAR2(20)   - ���깆�� ���대�� : 濡�洹몄�� �ъ�⑹���� ���대��
WRITER             VARCHAR2(50)   - ���깆�� �대� : 濡�洹몄�� �ъ�⑹���� �대�
SUBJECT            VARCHAR2(500)  - 寃���湲� ��紐� : ���κ�
REG_DATE           DATE           - 寃���湲� ���깆�쇱�� : ����(���λ��吏�)  
READCOUNT          NUMBER(4)      - 寃���湲� 議고���� : 0
REF                NUMBER(4)      - 寃���湲� 洹몃９踰��� : �듦�
RE_STEP            NUMBER(4)      - 寃���湲� 洹몃９���� : �듦�
RE_LEVEL           NUMBER(4)      - 寃���湲� 源��� : �듦� 
CONTENT            VARCHAR2(4000) - 寃���湲� �댁�� : ���κ�
IP                 VARCHAR2(20)   - 寃���湲� ���� 而댄�⑦�곗�� IP 二쇱�� : �대�쇱�댁�명�� IP 二쇱��
STATUS             NUMBER(1)      - 寃���湲� ���� : 0(�쇰�湲�), 1(鍮�諛�湲�), 9(����湲�)
*/
public class BoardDTO {
	private int num;
	private String id;
	private String writer;
	private String subject;
	private String regDate;
	private int readCount;
	private int ref;
	private int reStep;
	private int reLevel;
	private String content;
	private String ip;
	private int status;
	private int recnt;
	
	
	public BoardDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getReStep() {
		return reStep;
	}

	public void setReStep(int reStep) {
		this.reStep = reStep;
	}

	public int getReLevel() {
		return reLevel;
	}

	public void setReLevel(int reLevel) {
		this.reLevel = reLevel;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getRecnt() {
		return recnt;
	}

	public void setRecnt(int recnt) {
		this.recnt = recnt;
	}
	
}

package util;

public class Utility {
	//JSON ������ �ؽ�Ʈ ����Ÿ���� ǥ�� �Ұ����� ���ڸ� �����(Escape Character)�� ��ȯ�Ͽ� ��ȯ�ϴ� �޼ҵ�
	public static String toJSON(String source) {
		return source.replace("\\", "\\\\").replace("\"", "\\\"")
			.replace("\'", "\\\'").replace("\n", "\\n").replace("\r\n", "\\n");
	}
}

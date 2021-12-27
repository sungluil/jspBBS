package util;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class FolderInReader {
	private static List<String> list = new ArrayList<String>();

	public static void main(String[] args) {
		String message = null;
		String filePath = "C:/Java/workspace/jspBBS/WebContent/resources/fileFolder";
		File path = new File(filePath);
		if (path.exists() == false) {
			System.out.println("경로가 존재하지 않습니다");
		}

		File[] fileList = path.listFiles();
		int tab = 1;
		for (int i = 1; i < fileList.length; i++) {
			if (fileList[i].isDirectory()) {
				message = "[디렉토리] ";
				message += fileList[i].getName();
				System.out.println(message);
				subDirList(fileList[i].getName(), tab);
				Collections.reverse(list);
				for (String str : list) {
					System.out.println(str);
				}
				list.clear();
			} else {
				message = "[파일] ";
				message += fileList[i].getName();
				System.out.println(message);

			}

		}
	}
	private static void subDirList(String source, int tab){
		File dir = new File(source); 
		File[] fileList = dir.listFiles(); 
 		String sTab = "";
		for ( int i =1 ; i < tab ; i++){
			sTab +="\t";
		}
		
		try {
			for(int i = 1 ; i < fileList.length ; i++) {
				File file = fileList[i]; 
				if(file.isFile()){
					//파일이 있다면 파일 이름 출력
					if( i == 0 ) {
						//System.out.println("[디렉토리 이름] = " + dir.getPath()   );
						list.add("[디렉토리 이름1] = " + dir.getPath() ) ;
					}
					//System.out.println(sTab + " 파일 이름 = " + file.getName());
					list.add(sTab + " 파일 이름 = " + file.getName() );
				} else if(file.isDirectory()) { 
					// 서브디렉토리가 존재하면 재귀적 방법으로 다시 탐색
					subDirList(file.getCanonicalPath().toString(),tab+1);
					list.add("[디렉토리 이름2] = " + dir.getPath() );
					//System.out.println("[디렉토리 이름] = " + dir.getPath()   );

				}
			}
		}catch(IOException e){
			e.printStackTrace();
		}
	}
}

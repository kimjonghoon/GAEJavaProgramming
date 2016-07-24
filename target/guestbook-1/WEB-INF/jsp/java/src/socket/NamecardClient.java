package net.java_school.socket.test;

import java.io.*;
import java.net.*;
public class NamecardClient {
	static final String enter = System.getProperty("line.separator");
	private Socket socket;
	
	public NamecardClient(String ip, int port) throws IOException {
		socket = getSocket(ip, port);
	}
	
	public void showMenu() throws IOException {
		OutputStream os = null;
		InputStream is = null;
		BufferedWriter bw = null;
		BufferedReader br = null;
		BufferedReader input = null;
		String menu = null;
		String result = null;
		String send = null;
		
		do {
			System.out.println("�޴��� �����ϼ���");
            System.out.println("1.���Ե��");
            System.out.println("2.���Ը��");
            System.out.println("3.���Ի���");
            System.out.println("4.���Լ���");
            System.out.println("5.���԰˻�");
            System.out.println("q.����");
            
			os = socket.getOutputStream();
			is = socket.getInputStream();
			bw = new BufferedWriter(new OutputStreamWriter(os));
			br = new BufferedReader(new InputStreamReader(is));
			input = new BufferedReader(new InputStreamReader(System.in));
			menu = input.readLine();
			if (menu.equals("1")) {
				System.out.print("�̸��� �Է��ϼ���>>");
                String name = input.readLine();
                System.out.print("ȸ����� �Է��ϼ���>>");
                String company = input.readLine();
                System.out.print("����ȭ�� �Է��ϼ���>>");
                String mobile = input.readLine();
                System.out.print("�̸����� �Է��ϼ���>>");
                String email = input.readLine();
                send = "add$"+name+"$"+company+"$"+mobile+"$"+email;
			} else if (menu.equals("2")) {
				send = "list";
			} else if (menu.equals("3")) {
				send = "del";
			} else if (menu.equals("4")) {
				send = "edit";
			} else if (menu.equals("5")) {
				send = "find";
			} else if (menu.equals("q")) {
				send = "q";
			}
			send += enter;
			bw.write(send);
			bw.flush();
			if (menu.equals("q")) {
				break;
			}
			result = br.readLine();
			System.out.println(result);
		} while(true);
		input.close();
		bw.close();
		br.close();
		socket.close();
	}
	
	public Socket getSocket(String ip, int port) {
		Socket socket = null;
		try {
			socket = new Socket(ip, port);
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(0);
		}
		return socket;
	}
	
	public static void main(String[] args) throws IOException {
		NamecardClient namecardClient = new NamecardClient("localhost", 3000);
		namecardClient.showMenu();
	}
	
}

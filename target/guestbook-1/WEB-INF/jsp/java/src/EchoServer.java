
import java.io.*;
import java.net.*;
public class  EchoServer{
	static final String enter = System.getProperty("line.separator");
	ServerSocket serverSocket;
    
	public EchoServer(int port) {
		try {
			serverSocket = new ServerSocket(port);
		} catch(IOException e) {
			e.printStackTrace();
			System.exit(0);
		}
		
		while(true) {
			try {
				System.out.println("Ŭ���̾�Ʈ�� ��û�� ��ٸ��� ��");
				Socket socket = serverSocket.accept();
				System.out.println("Ŭ���̾�Ʈ�� IP �ּ� : " + socket.getInetAddress().getHostAddress());
				InputStream is = socket.getInputStream();
				OutputStream os = socket.getOutputStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(is));
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
				String message = br.readLine();
				System.out.println("���Ÿ޽��� : "+ message);
				message = message + enter;
				bw.write(message);
				bw.flush();
				br.close();
				bw.close();
				socket.close();
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
    public static void main(String[] args){
        new EchoServer(3000);
    }
}

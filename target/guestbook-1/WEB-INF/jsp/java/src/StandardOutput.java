public class StandardOutput {
	public static void main(String[] args) {
		System.out.println();		// �ܼ��� ���� �ٲ۴�(����)
		
		System.out.println(true);	// �Ҹ����� ����ϰ� ����
		
		System.out.println('A');	// char 'A'�� ����ϰ� ����
		
		char[] x = {'A','B','C'};
		System.out.println(x);		// char �� �迭�� ����ϰ� ����
		
		System.out.println(99.9);	// double �� �ڷḦ ����ϰ� ����
		
		System.out.println(99.9F);	// float �� �ڷḦ ����ϰ� ����
		
		System.out.println(100);	// int �� �ڷḦ ����ϰ� ����
		
		System.out.println(40000000L); // long �� �ڷḦ ����ϰ� ����
		
		System.out.println(System.out);	// �ش� ��ü�� ����ϰ� ����

		System.out.println("ǥ����¸޼ҵ� �׽�Ʈ"); // ���ڿ��� ����ϰ� ����
	}
}
package net.java_school.javabank;

import java.io.*;

public class BankCUI {
	
	private Bank bank = new Bank();
	
	{
		// �׽�Ʈ ������
		bank.addCustomer("kim", "������");
		bank.addCustomer("park", "������");
		Customer customer = bank.getCustomer("kim");
		customer.addAccount("111", 1000);
		customer = bank.getCustomer("park");
		customer.addAccount("222", 500);
	}
	
	public BankCUI() throws IOException {
		showMenu();
	}
	
	public void showMenu() throws IOException {
		String menu = null;
		String id = null;
		String name = null;
		
		do {
			System.out.println(" ** �޴��� �����ϼ��� ** ");
			System.out.println(" 1 *** �? ���   ");
			System.out.println(" 2 *** �? �˻�   ");
			System.out.println(" 3 *** �? ���   ");
			System.out.println(" 4 *** ���� ��   ");
			System.out.println(" 5 *** �Ա�   ");
			System.out.println(" 6 *** ���   ");
			System.out.println(" q *** ����   ");
			System.out.println(" ********************** ");
			System.out.print(">>");
			BufferedReader br = 
				new BufferedReader(new InputStreamReader(System.in));
			menu = br.readLine();
			
			try {
				if ( menu.equals("1") ) {
					// �? ���
					System.out.print("���̵� �Է��ϼ���>>");
					id = br.readLine();
					System.out.print("�̸��� �Է��ϼ���>>");
					name = br.readLine();
					bank.addCustomer(id, name);
					Customer customer = bank.getCustomer(id);
					System.out.print("���¹�ȣ�� �Է��ϼ���>>");
					String accountNo = br.readLine();
					System.out.print("�ʱ� �ܾ��� �Է��ϼ���>>");
					long balance = Long.parseLong(br.readLine());
					customer.addAccount(accountNo, balance);
				} else if ( menu.equals("2") ) {
					// �? �˻�
					System.out.print("���̵� �Է��ϼ���>>");
					id = br.readLine();
					Customer customer = bank.getCustomer(id);
					System.out.println(
							customer.getId() + ":" + 
							customer.getName());
					Account[] accounts = customer.getAccounts();
					int totalAccount = customer.getTotalAccount();
					for ( int i = 0; i < totalAccount; i++ ) {
						System.out.println(
								"\t" + "���¹�ȣ:" + 
								accounts[i].getAccountNo() + " �ܰ�:" +
								accounts[i].getBalance() + "��");
					}
				} else if ( menu.equals("3") ) {
					// �? ���
					Customer[] customers = bank.getCustomers();
					int totalCustomer = bank.getTotalCustomer();
					for ( int i = 0; i < totalCustomer; i++ ) {
						System.out.println(
								customers[i].getId() + ":" + 
								customers[i].getName());
						Account[] accounts = customers[i].getAccounts();
						int totalAccount = customers[i].getTotalAccount();
						for ( int j = 0; j < totalAccount; j++ ) {
							System.out.println(
									"\t" + "���¹�ȣ:" + 
									accounts[j].getAccountNo() + " �ܰ�:" +
									accounts[j].getBalance() + "��");
						}
						System.out.println("--------------------------------");
					}
				} else if (menu.equals("4")) {
					// ���� ��
				} else if (menu.equals("5")) {
					// �Ա�
				} else if (menu.equals("6")) {
					// ���
				}
				System.out.println();
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while ( !menu.equals("q") );
	}
	
	public static void main(String[] args) throws IOException {
		new BankCUI();
	}
	
}
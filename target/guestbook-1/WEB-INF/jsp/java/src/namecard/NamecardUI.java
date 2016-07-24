package net.java_school.namecard;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class NamecardUI {
	
	private NamecardManager cardMgr = new NamecardManager();;
	
	{
		cardMgr.addCard(new Namecard("������","��ƿ������θ�Ʈ ","���","010-1234-5678","02-555-0987","02-555-9876","taehee@navar.com","���� ���ʱ�"));
		cardMgr.addCard(new Namecard("������","��ü����������Ƽ�� ","����","010-0987-6543","00700-122345678","00700-03938937","jisungpark@navar.com","���� ��ü����"));
	}
	
	public NamecardUI(){}

	public void showMenu() throws IOException {
		
		String menu = null;
		
		do{
			System.out.println("�޴��� �����ϼ���");
			System.out.println("1.���Ե��");
			System.out.println("2.���Ը��");
			System.out.println("3.���Ի���");
			System.out.println("4.���Լ���");
			System.out.println("5.���԰˻�");
			System.out.println("q.����");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			
			menu = br.readLine();	
			try {
				if (menu.equals("1")) {
					System.out.print("�̸��� �Է��ϼ���>>");
					String name = br.readLine();
					
					System.out.print("ȸ����� �Է��ϼ���>>");
					String company = br.readLine();
					
					System.out.print("��å�� �Է��ϼ���>>");
					String title = br.readLine();
					
					System.out.print("����ȭ�� �Է��ϼ���>>");
					String mobile = br.readLine();
					
					System.out.print("ȸ����ȭ�� �Է��ϼ���>>");
					String phone = br.readLine();

					System.out.print("�ѽ��� �Է��ϼ���>>");
					String fax = br.readLine();
					
					System.out.print("�̸����� �Է��ϼ���>>");
					String email = br.readLine();

					System.out.print("ȸ���ּҸ� �Է��ϼ���>>");
					String address = br.readLine();

					Namecard card = new Namecard(name, company, title, mobile, phone, fax, email, address);
					cardMgr.addCard(card);
				} else if (menu.equals("2")) {
					ArrayList<Namecard> cards = cardMgr.getCards();
					int totalCard = cards.size();
					for(int i = 0; i < totalCard; i++) {
						System.out.println(cards.get(i).toString());
					}
					System.out.println();
				} else if (menu.equals("3")) {
					System.out.print("������ �̸��� �Է��ϼ���>>");
					String name = br.readLine();
					ArrayList<Namecard> searchCards = cardMgr.findCard(name);
					int totalCard = searchCards.size();
					for (int i = 0; i < totalCard; i++) {
						System.out.println(searchCards.get(i).toString());
					}
					if ( totalCard != 0) {
						System.out.print("������ ��ȣ�� �����ϼ���>>");
						int id = Integer.parseInt(br.readLine());
						cardMgr.deleteCard(id);
					}
				} else if (menu.equals("4")) {
					System.out.print("������ ������ �̸��� �Է��ϼ���>>");
					String name = br.readLine();
					ArrayList<Namecard> searchCards = cardMgr.findCard(name);
					int totalCard = searchCards.size();
					for (int i = 0; i < totalCard; i++) {
						System.out.println(searchCards.get(i).toString());
					}
					if ( totalCard != 0) {
						System.out.print("������ ���Թ�ȣ�� �����ϼ���>>");
						int id = Integer.parseInt(br.readLine());
						Namecard card = cardMgr.getCard(id);

						System.out.print("�̸��� �����Ϸ���  �Է��ϼ��� >>");
						name = br.readLine();
						if (!name.equals("")) {
							card.setName(name);
						}

						System.out.print("ȸ����� �����Ϸ���  �Է��ϼ���>>");
						String company = br.readLine();
						if (!company.equals("")) {
							card.setCompany(company);
						}
						
						System.out.print("Ÿ��Ʋ�� �����Ϸ���  �Է��ϼ���>>");
						String title = br.readLine();
						if (!title.equals("")) {
							card.setTitle(title);
						}
						
						System.out.print("����ȭ�� �����Ϸ���  �Է��ϼ���>>");
						String mobile = br.readLine();
						if (!mobile.equals("")) {
							card.setMobile(mobile);
						}	
						
						System.out.print("ȸ����ȭ�� �����Ϸ���  �Է��ϼ���>>");
						String phone = br.readLine();
						if (!phone.equals("")){
							card.setAddress(phone);
						}
						
						System.out.print("�ѽ��� �����Ϸ���  �Է��ϼ���>>");
						String fax = br.readLine();
						if (!fax.equals("")) {
							card.setFax(fax);
						}
						System.out.print("�̸����� �����Ϸ���  �Է��ϼ���>>");
						String email = br.readLine();
						if (!email.equals("")) {
							card.setEmail(email);
						}

						System.out.print("ȸ���ּҸ� �����Ϸ���  �Է��ϼ���>>");
						String address = br.readLine();
						if (!address.equals("")) {
							card.setFax(address);
						}
					}
				} else if (menu.equals("5")) {
					System.out.print("�˻��� �̸��� �Է��ϼ���>>");
					String name = br.readLine();
					ArrayList<Namecard> cards = cardMgr.findCard(name);
					int totalCard = cards.size();
					for(int i = 0; i < totalCard; i++) {
						System.out.println(cards.get(i).toString());
					}
					System.out.println();
				}
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		} while(!menu.equals("q"));
	}
	
	public static void main(String[] args) throws IOException {
		NamecardUI cardUI = new NamecardUI();
		cardUI.showMenu();
	}

}
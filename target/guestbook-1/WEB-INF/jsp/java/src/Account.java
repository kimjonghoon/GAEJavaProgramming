// Ŭ������ Account �� �빮�ڷ� ����
public class Account {
  
  // ������ accountNo �� ù���ڴ� �ҹ��� �ι�° ������ �빮�ڷ� ����
  private String accountNo; 
  
  // ���� balance �� �ҹ��ڷ� ����
  private int balance;

  // setBalance�� �ҹ��ڷ� ���� �ι�° ���� Balance �� �빮�ڷ� ����
  public void setBalance(int amount) { 
    balance = balance + amount;
  }
  
  // getBalance �� �ҹ��ڷ� ���� �ι�° ���� Balance�� �빮�ڷ� ����
  public int getBalance() { 
    return balance;
  }
}

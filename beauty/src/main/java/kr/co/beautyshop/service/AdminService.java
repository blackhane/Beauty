package kr.co.beautyshop.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.beautyshop.dao.AdminDAO;
import kr.co.beautyshop.vo.Product1VO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;
	
	//��ǰ���
	public int insertProduct(Product1VO vo) {
		//��ǰ����� �� �̹��� ���� ���ε�
		fileUpload(vo);
		
		//���ε� �ǸŰ��� ���
		int price = vo.getPrice();
		int discount = vo.getDiscount();
		int disPrice = price * (100-discount)/100;
		vo.setDisPrice(disPrice);
		
		//��ǰ���
		int result = dao.insertProduct(vo);
		return result;
	}
	
	//���������������� ��ǰ��� �ҷ�����
	public List<Product1VO> selectProducts(List<String> collection){
		return dao.selectProducts(collection);
	}
	
	//��ǰ �����ϱ�
	public int deleteProduct(String prodNo) {
		return dao.deleteProduct(prodNo);
	}
	
	//��ǰ �˻��ϱ�
	public List<Product1VO> searchProduct(String[] arg0,String param2,String arg2){
		return dao.searchProduct(arg0, param2, arg2);
	}
	
	/* ��ǰ��� ����¡ ó�� */
	//��ǰ ���� ����
	public int selectCountProducts(List<String> collection) {
		return dao.selectCountProducts(collection);
	}
	
	//���� ������ ��ȣ
	public int getCurrentPage(String pg) {
		int currentPage = 1;
		
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}

		 return currentPage;
	}
	
	//������ ���۰�
	public int getLimitStart(int currentPage) {
		return (currentPage -1)* 10;
	}
	
	//������ ������ ��ȣ
	public int getLastPageNum(int total) {
		int lastPageNum = 0;
		
		if(total % 10 == 0) {
			lastPageNum = total / 10;
		}else {
			lastPageNum = total / 10 + 1;
		}
		
		return lastPageNum;
	}
	
	//������ ���۹�ȣ
	public int getPageStartNum(int total, int param3) {
		return total - param3;
	}
	
	//������ �׷�
	public int[] getPageGroup(int currentPage, int lastPageNum) {
		int groupCurrent = (int) Math.ceil(currentPage/10.0);
		int groupStart = (groupCurrent - 1)*10+1;
		int groupEnd = groupCurrent * 10;
		
		if(groupEnd > lastPageNum) {
			groupEnd = lastPageNum;
		}

		int[] groups = {groupStart, groupEnd};
		
		return groups;
	}
	
	
	//��ǰ����� �� ���� ���ε�
	@Value("${spring.servlet.multipart.location}")
	private String uploadPath;
	
	public void fileUpload(Product1VO vo) {
		MultipartFile file1 = vo.getFile1();
		MultipartFile file2 = vo.getFile2();
		MultipartFile file3 = vo.getFile3();
		MultipartFile file4 = vo.getFile4();
		MultipartFile file5 = vo.getFile5();
		MultipartFile file6 = vo.getFile6();
		MultipartFile file7 = vo.getFile7();
		MultipartFile file8 = vo.getFile8();
		MultipartFile file9 = vo.getFile9();
		
		if(!file1.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file1.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb1(newName);
			
			//���� ����
			try {
				file1.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file2.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file2.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb2(newName);
			
			//���� ����
			try {
				file2.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file3.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file3.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb3(newName);
			
			//���� ����
			try {
				file3.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file4.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file4.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb4(newName);
			
			//���� ����
			try {
				file4.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file5.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file5.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb5(newName);
			
			//���� ����
			try {
				file5.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file6.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file6.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb6(newName);
			
			//���� ����
			try {
				file6.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file7.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file7.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setDetail1(newName);
			
			//���� ����
			try {
				file7.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file8.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file8.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setDetail2(newName);
			
			//���� ����
			try {
				file8.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file9.isEmpty()) {
			//�ý��� ���
			String path = new File(uploadPath).getAbsolutePath();
			
			//�� ���ϸ� ����
			String oriName = file9.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setDetail3(newName);
			
			//���� ����
			try {
				file9.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
	
}
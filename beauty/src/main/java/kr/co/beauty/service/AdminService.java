package kr.co.beauty.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.beauty.dao.AdminDAO;
import kr.co.beauty.vo.Product1VO;

@Service
public class AdminService {
	
	@Autowired
	private AdminDAO dao;
	
	//상품등록
	public int insertProduct(Product1VO vo) {
		//상품등록할 때 이미지 파일 업로드
		fileUpload(vo);
		
		//할인된 판매가격 등록
		int price = vo.getPrice();
		int discount = vo.getDiscount();
		int disPrice = price * (100-discount)/100;
		vo.setDisPrice(disPrice);
		
		//상품등록
		int result = dao.insertProduct(vo);
		return result;
	}
	
	//관리자페이지에서 상품목록 불러오기
	public List<Product1VO> selectProducts(String param1,String arg1, int param3){
		return dao.selectProducts(param1,arg1, param3);
	}
	
	public List<Product1VO> selectProductByCheckBox(List<String> collection){
		return dao.selectProductByCheckBox(collection);
	}
	
	//상품 삭제하기
	public int deleteProduct(String prodNo) {
		return dao.deleteProduct(prodNo);
	}
	
	//상품 검색하기
	public List<Product1VO> searchProduct(String param1,String arg1,String param2,String arg2){
		return dao.searchProduct(param1, arg1, param2, arg2);
	}
	
	/* 상품목록 페이징 처리 */
	//상품 개수 세기
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	
	//현재 페이지 번호
	public int getCurrentPage(String pg) {
		int currentPage = 1;
		
		if(pg != null) {
			currentPage = Integer.parseInt(pg);
		}

		 return currentPage;
	}
	
	//페이지 시작값
	public int getLimitStart(int currentPage) {
		return (currentPage -1)* 10;
	}
	
	//마지막 페이지 번호
	public int getLastPageNum(int total) {
		int lastPageNum = 0;
		
		if(total % 10 == 0) {
			lastPageNum = total / 10;
		}else {
			lastPageNum = total / 10 + 1;
		}
		
		return lastPageNum;
	}
	
	//페이지 시작번호
	public int getPageStartNum(int total, int param3) {
		return total - param3;
	}
	
	//페이지 그룹
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
	
	
	//상품등록할 때 파일 업로드
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
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file1.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb1(newName);
			
			//파일 저장
			try {
				file1.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file2.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file2.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb2(newName);
			
			//파일 저장
			try {
				file2.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file3.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file3.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb3(newName);
			
			//파일 저장
			try {
				file3.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file4.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file4.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb4(newName);
			
			//파일 저장
			try {
				file4.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file5.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file5.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb5(newName);
			
			//파일 저장
			try {
				file5.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file6.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file6.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setThumb6(newName);
			
			//파일 저장
			try {
				file6.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file7.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file7.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setDetail1(newName);
			
			//파일 저장
			try {
				file7.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file8.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file8.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setDetail2(newName);
			
			//파일 저장
			try {
				file8.transferTo(new File(path, newName));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(!file9.isEmpty()) {
			//시스템 경로
			String path = new File(uploadPath).getAbsolutePath();
			
			//새 파일명 생성
			String oriName = file9.getOriginalFilename();
			String ext = oriName.substring(oriName.lastIndexOf("."));
			String newName = UUID.randomUUID().toString()+ext;
			
			vo.setDetail3(newName);
			
			//파일 저장
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
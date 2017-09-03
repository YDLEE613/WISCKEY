package kr.madison.board.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.madison.board.vo.BoardVO;
import kr.madison.common.dao.CommonDAO;

@Repository
public class BoardDAO extends CommonDAO{

	public int findBoardTotalCnt(BoardVO paramVO){
		return getSqlSession().selectOne("Board.findBoardTotalCnt", paramVO);
	}
	
	public List<BoardVO> findBoardList(BoardVO paramVO){
		return getSqlSession().selectList("Board.findBoardList", paramVO);
	}
	
	public BoardVO findBoardContent(BoardVO paramVO){
		return getSqlSession().selectOne("Board.findBoardContent", paramVO);
	}
	
	public int addBoardData(BoardVO paramVO){
		getSqlSession().insert("Board.addBoardData", paramVO);
		return paramVO.getBrdid();
	}
	
	public int addBoardReply(BoardVO paramVO){
		getSqlSession().insert("Board.addBoardReply", paramVO);
		return paramVO.getRepid();
	}
	
	public int modBoardCount(BoardVO paramVO){
		return getSqlSession().update("Board.modBoardCount", paramVO);
	}
	
	public int modBoardLikes(BoardVO paramVO){
		return getSqlSession().update("Board.modBoardLikes", paramVO);
	}
	
	public int modBoardDislikes(BoardVO paramVO){
		return getSqlSession().update("Board.modBoardDislikes", paramVO);
	}
	
	public int modRepLikes(BoardVO paramVO){
		return getSqlSession().update("Board.modRepLikes", paramVO);
	}
	
	public int modRepDislikes(BoardVO paramVO){
		return getSqlSession().update("Board.modRepDislikes", paramVO);
	}
	
	public List<BoardVO> findBoardReply(BoardVO paramVO){
		return getSqlSession().selectList("Board.findBoardReply", paramVO);
	}
	
	public int getReplyCount(BoardVO paramVO){
		return getSqlSession().selectOne("Board.getReplyCount", paramVO);
	}
	
	public int modBoardData(BoardVO paramVO){
		return getSqlSession().update("Board.modBoardData", paramVO);
	}
	
	public List<BoardVO> getFrtypes(BoardVO paramVO){
		return getSqlSession().selectList("Board.getFrtypes", paramVO);
	}
	public void delBoardData(BoardVO paramVO){
		getSqlSession().delete("Board.delBoardData", paramVO);
	}
	public void delBoardReplyData(BoardVO paramVO){
		getSqlSession().delete("Board.delBoardReplyData", paramVO);
	}
	
	public BoardVO checkLikes(BoardVO paramVO){
		return getSqlSession().selectOne("Board.checkLikes", paramVO);
	}
	public int addBoardLikes(BoardVO paramVO){
		return getSqlSession().insert("Board.addBoardLikes", paramVO);
	}
	public BoardVO checkRepLikes(BoardVO paramVO){
		return getSqlSession().selectOne("Board.checkRepLikes", paramVO);
	}
	public int addBoardRepLikes(BoardVO paramVO){
		return getSqlSession().insert("Board.addBoardRepLikes", paramVO);
	}
	public void delBoardLikes(BoardVO paramVO){
		getSqlSession().delete("Board.delBoardLikes", paramVO);
	}
	public void delBoardReplyLikes(BoardVO paramVO){
		getSqlSession().delete("Board.delBoardReplyLikes", paramVO);
	}
	
	public int modBoardReply(BoardVO paramVO){
		return getSqlSession().update("Board.modBoardReply", paramVO);
	}
	
	public void delBoardReply(BoardVO paramVO){
		getSqlSession().delete("Board.delBoardReply", paramVO);
	}
	
	public BoardVO findBoardReplyData(BoardVO paramVO){
		return getSqlSession().selectOne("Board.findBoardReplyData", paramVO);
	}
	
	public List<BoardVO> findCommentList(BoardVO paramVO){
		return getSqlSession().selectList("Board.findCommentList", paramVO);
	}
	
	public int getCommentCount(BoardVO paramVO){
		return getSqlSession().selectOne("Board.getCommentCount", paramVO);
	}
	public int undoBoardLikes(BoardVO paramVO){
		return getSqlSession().update("Board.undoBoardLikes", paramVO);
	}
	public int undoBoardDislikes(BoardVO paramVO){
		return getSqlSession().update("Board.undoBoardDislikes", paramVO);
	}
	public int undoBoardRepLikes(BoardVO paramVO){
		return getSqlSession().update("Board.undoBoardRepLikes", paramVO);
	}
	public int undoBoardRepDislikes(BoardVO paramVO){
		return getSqlSession().update("Board.undoBoardRepDislikes", paramVO);
	}
}

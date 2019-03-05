package cn.doreou.mapper;

import cn.doreou.model.Book;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookMapper {
    List<Book> getAllSubject();
}

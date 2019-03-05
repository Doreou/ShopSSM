package cn.doreou.service.impl;

import cn.doreou.mapper.BookMapper;
import cn.doreou.model.Book;
import cn.doreou.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookMapper bookMapper;

    public List<Book> getAllSubject(){
        List<Book> Allsubject=bookMapper.getAllSubject();
        return Allsubject;
    }
}

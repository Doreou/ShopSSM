<%@ page import="java.util.List" %>
<%@ page import="cn.doreou.model.GoodAndUser" %>
<%@ page import="cn.doreou.model.Goods" %><%--
  Created by IntelliJ IDEA.
  User: Holmes
  Date: 2019/4/6
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Object goodslist=session.getAttribute("AllSaleGoodsList");
    List<GoodAndUser> usersinfo=(List<GoodAndUser>) session.getAttribute("userinfo");
%>

<input id="page-way" style="display: none;" <%if(session.getAttribute("way")!=null){%>
       value="<%=session.getAttribute("way")%>"
    <%}else{%>
       value="asc"
    <%}%>>
<%
    if(goodslist!=null){
        for(Goods g:(List<Goods>)goodslist){%>
<li class="items clearfix" style="margin-left: 66px;">
    <div class="class-item">
        <div class="class-bg-layer"></div>
        <div class="class-item-bg">
            <a target="_blank" href="/Order/getgoodsinfo?id=<%=g.getGoods_id()%>" class="class-img">
                <img class="img-responsive lazyload" src="<%=g.getCover()%>" alt="<%=g.getGoods_title()%>" data-original="/Uploads/salebuy/2019-03-07/5c80d801426ca.png" style="display: block;">
            </a>
            <div class="pricehot clearfix">
                <span class="price">￥&nbsp;<span><%=g.getExpt_price()%></span></span>
                <span class="hot">点击数&nbsp;<span><%=g.getClickcount()%></span></span>
            </div>
            <a target="_blank" href="/sale/2671" class="title">
                <%=g.getGoods_title()%>                                    </a>
            <div class="some  clearfix">
                <span class="school">大连大学</span>
                <span class="renzheng">
                                <%for(GoodAndUser u:usersinfo){
                                    if (u.getGoods_id()==g.getGoods_id()){
                                        if(u.getMember_status()==0){%>
                                                未认证
                                        <%}else {%>
                                                已认证
                                        <%}
                                        }
                                        }%>
                            </span>
            </div>
        </div>
    </div>
</li>
<%}}%>

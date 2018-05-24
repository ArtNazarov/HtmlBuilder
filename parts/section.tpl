    <div id="sidedrawer" class="mui--no-user-select">
      <div id="sidedrawer-brand" class="mui--appbar-line-height">
        <span class="mui--text-title">{sitename}</span>
      </div>
      <div class="mui-divider"></div>
       {mainmenu}
    </div>
    <header id="header">
      <div class="mui-appbar mui--appbar-line-height">
        <div class="mui-container-fluid">
          <a class="sidedrawer-toggle mui--visible-xs-inline-block mui--visible-sm-inline-block js-show-sidedrawer">☰</a>
          <a class="sidedrawer-toggle mui--hidden-xs mui--hidden-sm js-hide-sidedrawer">☰</a>
          <span class="mui--text-title mui--visible-xs-inline-block mui--visible-sm-inline-block">Brand.io</span>
        </div>
      </div>
    </header>
    <div id="content-wrapper">
      <div class="mui--appbar-height"></div>
      <div class="mui-container-fluid">
        <br>
       
       <h2>Тема: {sectionTitle}</h2> 
	   <p>Материалы :</p>
	   <ul>{items}</ul>
      </div>
    </div>
    <footer id="footer">
      <div class="mui-container-fluid">
        <br>
        {footer}
      </div>
    </footer>

<?php
class smartbloghomelatestnewsOverride extends smartbloghomelatestnews {
    public function hookdisplayHomeBlog($params) {
        
               if(Module::isInstalled('smartblog') != 1){
                       $this->smarty->assign( array(
                                 'smartmodname' => $this->name
                        ));
                       return $this->display(__FILE__, 'views/templates/front/install_required.tpl');
               }
               else
               {
                           if (!$this->isCached('smartblog_latest_news.tpl', $this->getCacheId()))
                               {
                                   $view_data['posts'] = SmartBlogPost::GetPostLatestHome(Configuration::get('smartshowhomepost')); 
                                   $this->smarty->assign( array(
                                             'view_data'         => $view_data['posts']
                                   ));
                               }
                           return $this->display(__FILE__, 'views/templates/front/smartblog_latest_news.tpl', $this->getCacheId());
               }  
           }
}
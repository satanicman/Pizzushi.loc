<div class="block"><!-- 
    <h2 class='sdstitle_block'><a href="{smartblog::GetSmartBlogLink('smartblog')}"></a></h2> -->
    <div class="blog-wrapper-title-wrap">
        <span class="blog-wrapper-title">{l s='Latest News' mod='smartbloghomelatestnews'}</span>
    </div>
    <div class="sdsblog-box-content">
        {if isset($view_data) AND !empty($view_data)}
            {assign var='i' value=1}
            {foreach from=$view_data item=post}
               
                    {assign var="options" value=null}
                    {$options.id_post = $post.id}
                    {$options.slug = $post.link_rewrite}
                    <div id="sds_blog_post" class="clearfix">
                        <span class="news_module_image_holder col-md-3 com-xs-12">
                             <a href="{smartblog::GetSmartBlogLink('smartblog_post',$options)}"><img alt="{$post.title}" class="feat_img_small" src="{$modules_dir}smartblog/images/{$post.post_img}.jpg"></a>
                        </span>
                        <div class="blog-wrapper-text col-md-9 col-xs-12">
                            <a href="{smartblog::GetSmartBlogLink('smartblog_post',$options)}" class="sd_post_title">{$post.title}</a>
                            <p class="sd_post_description">
                                {$post.short_description|escape:'htmlall':'UTF-8'}
                            </p>
                        </div>
                    </div>
                
                {$i=$i+1}
            {/foreach}
        {/if}
     </div>
</div>
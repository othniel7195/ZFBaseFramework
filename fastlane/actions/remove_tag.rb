module Fastlane
  module Actions
    module SharedValues
      REMOVE_TAG_CUSTOM_VALUE = :REMOVE_TAG_CUSTOM_VALUE
    end

    class RemoveTagAction < Action
      def self.run(params)
      #获取参数
      tagName = params[:tag]
      #定义执行命令的数组
      cmds = []
      #删除本地tag
      cmds << "git tag -d #{tageName}"
      #删除远端tag
      cmds << "git push origin :#{tageName}"
      
      # 3、执行数组里面的所有的命令
      result = Actions.sh(cmds.join('&'))
      UI.message("执行完毕 remove_tag的操作 🚀")
      return result
      
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "输入标签，删除标签"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "我们可以使用这个标签来删除标签\n 使用方式是：\n remove_tag(tag:tagName)"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
# 传入tag值的参数描述，不可以忽略<必须输入>，字符串类型，没有默认值
         FastlaneCore::ConfigItem.new(key: :tag,
                                      description: "tag 号是多少",
                                      optional:false,# 是不是可以省略
                                      is_string: true, # true: 是不是字符串
                             ),
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['REMOVE_TAG_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["zhaofeng7195@yeah.net"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end

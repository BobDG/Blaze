Pod::Spec.new do |s|
  s.name           	= 'Blaze'
  s.version        	= '1.1.36'
  s.summary        	= 'Blazingly fast Tableviewcontroller framework'
  s.license 	    	= 'MIT'
  s.description    	= 'Blazingly fast Tableviewcontroller framework with many advantages'
  s.homepage       	= 'https://github.com/BobDG/Blaze'
  s.authors        	= {'Bob de Graaf' => 'graafict@gmail.com'}
  s.source         	= { :git => 'https://github.com/BobDG/Blaze.git', :tag => s.version.to_s }
  s.source_files   	= 'Blaze/**/*.{h,m}'
  s.resources 		= ['Blaze/**/*.{xib}', 'Blaze/**/*.{png}']
  s.platform       	= :ios, '14.0'
  s.requires_arc   	= true
  s.module_name 	= 'Blaze'
  s.dependency 		'AFNetworking'
  s.dependency 		'BDGImagePicker'
end

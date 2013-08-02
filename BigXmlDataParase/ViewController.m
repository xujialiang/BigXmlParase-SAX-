//
//  ViewController.m
//  BigXmlDataParase
//
//  Created by Elliott on 13-7-30.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import "ViewController.h"
#import "item.h"
@interface ViewController (){
    NSMutableArray *_itemData;

    NSString *sCurTag;
    item *dataitem;
    BOOL bdataitem;

    NSDate *startdate;
    NSDate *enddate;
    
    NSInteger datacount;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)parserDidStartDocument:(NSXMLParser *)parser{
    startdate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    self.startDate.text=[NSString stringWithFormat:@"开始时间:%@",[dateFormatter stringFromDate:startdate]];
}

//发现元素开始符的处理函数  （即报告元素的开始以及元素的属性） 
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if(qName){
        elementName = qName;
    }
    sCurTag =[[NSString alloc] initWithString:elementName];
    if([sCurTag isEqualToString:@"HotelInfoForIndex"]){
        dataitem=[[item alloc] init];
        dataitem.ExtensionData=@"";
        dataitem.Addtime=@"";
        dataitem.Deltime=@"";
        dataitem.Hotel_id=@"";
        dataitem.Hotel_name=@"";
        dataitem.Hotel_name_en=@"";
        dataitem.Isreserve=@"";
        dataitem.Modifytime=@"";
        bdataitem=YES;
    }
    
}

//处理标签包含内容字符 （报告元素的所有或部分内容） 
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // Save foundCharacters for later
    if(!sCurTag){
        return;
    }
    if(bdataitem)
    {
        if([sCurTag isEqualToString:@"ExtensionData"]){
            dataitem.ExtensionData =[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Addtime"]){
            dataitem.Addtime=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Deltime"]){
            dataitem.Deltime=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Hotel_id"]){
            dataitem.Hotel_id=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Hotel_name"]){
            dataitem.Hotel_name=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Hotel_name_en"]){
            dataitem.Hotel_name_en=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Isreserve"]){
            dataitem.Isreserve=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }else if([sCurTag isEqualToString:@"Modifytime"]){
            dataitem.Modifytime=[string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        //NSLog(@"foundCharacters Value:%@",string);
    }
}

//发现元素结束符的处理函数，保存元素各项目数据（即报告元素的结束标记）
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if(sCurTag) sCurTag=nil;
    if([elementName isEqualToString:@"HotelInfoForIndex"]){
        if(_itemData==nil){
            _itemData=[[NSMutableArray alloc] initWithObjects:@[dataitem], nil];
        }else{
            [_itemData addObject:dataitem];
        }
        //NSLog(@"count:%d",count++);
        self.count.text=[NSString stringWithFormat:@"数据量:%d",datacount++];
        dataitem=nil;
    }
}

//报告解析的结束 
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    enddate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    //NSLog(@"结束时间:%@", [dateFormatter stringFromDate:enddate]);
    self.endDate.text=[NSString stringWithFormat:@"结束时间:%@",[dateFormatter stringFromDate:enddate]];
    
    NSTimeInterval date1 = [startdate timeIntervalSinceReferenceDate];
    NSTimeInterval date2 = [enddate timeIntervalSinceReferenceDate];
    float interval = date2 - date1;
    NSLog(@"总共花费时间:%f", interval);
    self.costtime.text=[NSString stringWithFormat:@"耗时:%f",interval];
}

//报告不可恢复的解析错误
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@ with error %@",NSStringFromSelector(_cmd),parseError.localizedDescription);

}
-(void)parse{
    NSString  *filepath =[[NSBundle mainBundle] pathForResource:@"hotellist" ofType:@"xml"];
    NSData *data=[[NSData alloc] initWithContentsOfFile:filepath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
}
- (IBAction)btnparase:(id)sender {
    for (int i=0; i<=0; i++) {
        datacount=0;
        NSLog(@"第%d次",i);
        [self parse];
    }
}
@end

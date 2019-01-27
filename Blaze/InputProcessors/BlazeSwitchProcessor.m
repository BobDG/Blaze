//
//  BlazeSwitchProcessor.m
//  BlazeExample
//
//  Created by Bob de Graaf on 27/01/2019.
//  Copyright © 2019 GraafICT. All rights reserved.
//

#import "BlazeSwitchProcessor.h"

@interface BlazeSwitchProcessor() {
    
}

@property(nonatomic,strong) UISwitch *inputSwitch;

@end

@implementation BlazeSwitchProcessor

-(void)update
{
    self.inputSwitch = self.input;
    self.inputSwitch.on = [self.row.value boolValue];
    
    //Editable
    self.inputSwitch.userInteractionEnabled = !self.row.disableEditing;
    
    //Add target (since inputprocessors are recreated continuously we need to always add this here)
    [self.inputSwitch addTarget:self action:@selector(cellSwitched) forControlEvents:UIControlEventValueChanged];
}

-(void)cellSwitched
{
    if(self.row.disableEditing) {
        return;
    }
    
    self.row.value = @(self.inputSwitch.on);
    [self.row updatedValue:self.row.value];
}

@end

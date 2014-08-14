//
//  PostCommentViewController.m
//  Footbook
//
//  Created by ETC ComputerLand on 8/13/14.
//  Copyright (c) 2014 cmeats. All rights reserved.
//

#import "PostCommentViewController.h"
#import "Comment.h"

@interface PostCommentViewController ()
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end

@implementation PostCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.profile.photo) {
        self.thumbnailImage.image = [UIImage imageWithData:self.profile.photo];
    }
    [self.commentTextView becomeFirstResponder];
}
- (IBAction)onPostComment:(UIBarButtonItem *)sender
{
    Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.profile.managedObjectContext];
    comment.text = self.commentTextView.text;
    [self.profile addCommentsObject:comment];
    [self.profile.managedObjectContext save:nil];
    [self performSegueWithIdentifier:@"unwindFromPostComment" sender:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

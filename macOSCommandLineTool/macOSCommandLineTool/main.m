//
//  main.m
//  macOSCommandLineTool
//
//  Created by huangaengoln on 2017/11/24.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import <Foundation/Foundation.h>
//单链表的基本结构：
typedef struct node {
    char *data;
    struct node *next;
} node_t;
//设定一个打印链表的函数:
void list_display(node_t *head) {
    for (; head; head = head->next) {
        printf("%s ",head->data);
    }
    printf("\n");
}
/** 1.计算一个链表的长度（复杂度O(n)）
 算法：定义一个p指针指向头结点，步长为1，遍历链表。  */
int list_len(node_t *head) {
    int i;
    for (i = 0; head; head = head->next, i++){}
    return i;
}
/** 2.反转链表（复杂度O(n)）
 算法：t遍历链表, q记录t的上一个结点, p是一个临时变量用来缓存t的值。 */
void reverse(node_t *head) {
    node_t *p = 0,*q = 0,*t = 0;
    for (t = head; t; p = t,t = t->next, p->next = q, q = p);
}
/** 3.查找倒数第k个元素（尾结点记为倒数第0个）（复杂度O(n)）
 算法：2个指针p, q初始化指向头结点.p先跑到k结点处, 然后q再开始跑, 当p跑到最后跑到尾巴时, q正好到达倒数第k个。  */


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        

    }
}










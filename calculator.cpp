#include "calculator.h"
#include "./ui_calculator.h"

Calculator::Calculator(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::Calculator)
{
    ui->setupUi(this);
    memset(&sreg, 0, sizeof(sreg));
}

Calculator::~Calculator()
{
    delete ui;
}

void Calculator::cal()
{
    switch (sreg.symbol[0]) {
    case '+':
        sreg.results = sreg.results + sreg.numnext;
        break;
    case '-':
        if(sreg.numbefore==0 && sreg.results==0)
        {
            sreg.results = sreg.numnext;
            break;
        }
        sreg.results = sreg.results - sreg.numnext;
        break;
    case 'x':
        if(sreg.numbefore==0 && sreg.results==0)
        {
            sreg.results = sreg.numnext;
            break;
        }
        sreg.results = sreg.results * sreg.numnext;
        break;
    case '/':
        if(sreg.numbefore==0 && sreg.results==0)
        {
            sreg.results = sreg.numnext;
            break;
        }
        sreg.results = sreg.results / sreg.numnext;
        break;
    default:
        sreg.results = sreg.numbefore;
        break;
    }
    qDebug() << sreg.results;
}

void Calculator::HandlerNum(double num)
{
    if(sreg.isDouble)
    {
        sreg.dots += 1;
        QTextCursor cursor = ui->textBrowser->textCursor();
        if(sreg.numnext == 0)
        {
            cursor.movePosition(QTextCursor::End);
            cursor.insertText(QString::number(num));
            ui->textBrowser->setTextCursor(cursor);
            for(int i=0; i<sreg.dots; i++)
            {
                num = num / 10;
            }
            sreg.numnext += num;
            qDebug() << "n: " << sreg.numnext << "dots: " << sreg.dots;
            sreg.symbol[1] = 0;
            return;
        }
        cursor.movePosition(QTextCursor::End);
        cursor.insertText(QString::number(num));
        ui->textBrowser->setTextCursor(cursor);
        for(int i=0; i<sreg.dots; i++)
        {
            num = num / 10;
        }
        sreg.numnext += num;
        qDebug() << "n: " << sreg.numnext << "dots: " << sreg.dots;
        sreg.symbol[1] = 0;
        return;
    }
    QTextCursor cursor = ui->textBrowser->textCursor();
    if(sreg.numnext == 0)
    {
        cursor.movePosition(QTextCursor::End);
        cursor.insertText(QString::number(num));
        ui->textBrowser->setTextCursor(cursor);
        sreg.numnext = num;
        sreg.symbol[1] = 0;
        return;
    }
    cursor.movePosition(QTextCursor::End);
    cursor.insertText(QString::number(num));
    ui->textBrowser->setTextCursor(cursor);
    sreg.numnext = sreg.numnext * 10 + num;
    sreg.symbol[1] = 0;
}

void Calculator::HandlerSym(const char sym)
{
    sreg.isDouble = false;
    if(sreg.highDots < sreg.dots)
    {
        sreg.highDots = sreg.dots;
    }
    if(sreg.symbol[1] != 0)
    {
        return;
    }
    if(sreg.symbol[0] == 0 && sreg.numbefore == sreg.numnext)
    {
        QTextCursor cursor = ui->textBrowser->textCursor();
        sreg.symbol[0] = sym;
        sreg.symbol[1] = 1;
        cal();
        sreg.numbefore = sreg.numnext;
        sreg.numnext = 0;
        cursor.movePosition(QTextCursor::End);
        cursor.insertText("0" +QString(sym));
        ui->textBrowser->setTextCursor(cursor);
        return;
    }
    if(sreg.symbol[0] == 0)
    {
        QTextCursor cursor = ui->textBrowser->textCursor();
        sreg.symbol[0] = sym;
        sreg.symbol[1] = 1;
        cal();
        sreg.numbefore = sreg.numnext;
        sreg.numnext = 0;
        cursor.movePosition(QTextCursor::End);
        cursor.insertText(QString(sym));
        ui->textBrowser->setTextCursor(cursor);
        return;
    }
    QTextCursor cursor = ui->textBrowser->textCursor();
    cal();
    sreg.symbol[0] = sym;
    sreg.symbol[1] = 1;
    sreg.numbefore = sreg.numnext;
    sreg.numnext = 0;
    cursor.movePosition(QTextCursor::End);
    cursor.insertText(QString(sym));
    ui->textBrowser->setTextCursor(cursor);
}

void Calculator::on_num1_pressed()
{
    HandlerNum(1);
}
void Calculator::on_num2_pressed()
{
    HandlerNum(2);
}
void Calculator::on_num3_pressed()
{
    HandlerNum(3);
}void Calculator::on_num4_pressed()
{
    HandlerNum(4);
}void Calculator::on_num5_pressed()
{
    HandlerNum(5);
}void Calculator::on_num6_pressed()
{
    HandlerNum(6);
}void Calculator::on_num7_pressed()
{
    HandlerNum(7);
}void Calculator::on_num8_pressed()
{
    HandlerNum(8);
}void Calculator::on_num9_pressed()
{
    HandlerNum(9);
}
void Calculator::on_symsum_pressed()
{
    cal();
    qDebug()<< sreg.numbefore << "-" << sreg.results << "-" << sreg.highDots;
    QTextCursor cursor = ui->textBrowser->textCursor();
    cursor.movePosition(QTextCursor::End);
    if(sreg.isSumDouble)
    {
        if(sreg.highDots < sreg.dots)
        {
            sreg.highDots = sreg.dots;
        }
        cursor.insertText(" = " + QString::number(sreg.results, 'f', sreg.highDots) + "\n" );
        ui->textBrowser->setTextCursor(cursor);
        memset(&sreg, 0, sizeof(sreg));
        return;
    }
    cursor.insertText(" = " + QString::number(static_cast<int>(sreg.results)) + "\n" );
    ui->textBrowser->setTextCursor(cursor);
    memset(&sreg, 0, sizeof(sreg));
}


void Calculator::on_num0_pressed()
{
    qDebug()<< sreg.numnext;
    if(sreg.numnext == 0 && !sreg.isDouble)
    {
        return;
    }
    if(sreg.isDouble)
    {
        QTextCursor cursor = ui->textBrowser->textCursor();
        cursor.movePosition(QTextCursor::End);
        cursor.insertText("0");
        ui->textBrowser->setTextCursor(cursor);
        sreg.symbol[1] = 0;
        sreg.dots += 1;
        return;
    }
    QTextCursor cursor = ui->textBrowser->textCursor();
    cursor.movePosition(QTextCursor::End);
    cursor.insertText(QString::number(0));
    ui->textBrowser->setTextCursor(cursor);
    sreg.numnext *= 10;
    sreg.symbol[1] = 0;
}


void Calculator::on_symadd_pressed()
{
    HandlerSym('+');
}
void Calculator::on_symred_pressed()
{
    HandlerSym('-');
}
void Calculator::on_symplus_pressed()
{
    HandlerSym('x');
}
void Calculator::on_symres_pressed()
{
    HandlerSym('/');
}
void Calculator::on_symdot_pressed()
{
    if(sreg.isDouble == true)
    {
        return;
    }
    sreg.isDouble = true;
    if(sreg.numnext == 0)
    {
        QTextCursor cursor = ui->textBrowser->textCursor();
        cursor.movePosition(QTextCursor::End);
        cursor.insertText("0.");
        ui->textBrowser->setTextCursor(cursor);
        sreg.dots = 0;
        sreg.isSumDouble = true;
        return;
    }
    QTextCursor cursor = ui->textBrowser->textCursor();
    cursor.movePosition(QTextCursor::End);
    cursor.insertText(".");
    ui->textBrowser->setTextCursor(cursor);
    sreg.dots = 0;
    sreg.isSumDouble = true;
}


#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QMainWindow>
#include <string.h>

/**
 * @brief The SumReg class
 * numbefore after new symbol click
 * numnext means now, before new symbol click
 * symbol[1] means does it clicked after last time. 1 for yes
 */
struct SumReg
{
    double numbefore;
    double numnext;
    double results;
    char symbol[2];
    bool isDouble;
    bool isSumDouble;
    unsigned int dots;
    unsigned int highDots;
};

QT_BEGIN_NAMESPACE
namespace Ui {
class Calculator;
}
QT_END_NAMESPACE

class Calculator : public QMainWindow
{
    Q_OBJECT

public:
    Calculator(QWidget *parent = nullptr);
    ~Calculator();

signals:
    void cusm();
private slots:
    void on_num2_pressed();
    void on_num1_pressed();
    void on_num3_pressed();
    void on_num4_pressed();
    void on_num5_pressed();
    void on_num6_pressed();
    void on_num7_pressed();
    void on_num8_pressed();
    void on_num9_pressed();

    void on_symsum_pressed();
    void on_num0_pressed();
    void on_symadd_pressed();
    void on_symred_pressed();
    void on_symplus_pressed();
    void on_symres_pressed();

    void on_symdot_pressed();

private:
    Ui::Calculator *ui;
    SumReg sreg;


private:
    void cal();
    void HandlerNum(double);
    void HandlerSym(const char);
};
#endif // CALCULATOR_H

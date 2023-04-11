#include <iostream>
#include <vector>
#include <string>
using namespace std;

int main () {
    int numAlmacene = rand()%4+1;
    int numAsentamiento = rand()%4+1;
    int numRover = rand()%4+1;
    int numPeticion = rand()%10+1;
    int numPersonal = 0;
    int numSuministro = 0;
    
    vector<string> almacenes;
    vector<string> asentamientos;
    vector<string> rovers;
    vector<string> peticiones;
    vector<bool> disponibleAlmancenes;
    vector<bool> disponibleAsentamientos;
    
    //map<string, pair<int, int>>???
    
    for (int i = 0; i < numAsentamiento; ++i) {
        string asentamiento = "as";
        asentamiento += to_string(i+1);
        asentamientos.push_back(asentamiento);
    }
    
    for (int i = 0; i < numAlmacene; ++i) {
        string almacene = "al";
        almacene += to_string(i+1);
        almacenes.push_back(almacene);
    }
    
    for (int i = 0; i < numRover; ++i) {
        string rover = "r";
        rover += to_string(i+1);
        rovers.push_back(rover);
    }
    
    for (int i = 0; i < numPeticion; ++i) {
        string peticion = "p";
        peticion += to_string(i+1);
        peticiones.push_back(peticion);
    }
    
    cout << "(define (problem rovers-basic)" << endl;
    cout << "        (:domain rovers)" << endl;
    cout << "        (:objects" << endl;
    cout << "                 ";
    for (int i = 0; i < numAsentamiento; ++i) {
        cout << " " << asentamientos[i];
    }
    cout << " - asentamiento" << endl;
    cout << "                 ";
    for (int i = 0; i < numAlmacene; ++i) {
        cout << " " << almacenes[i];
    }
    cout << " - almacen" << endl;
    cout << "                 ";
    for (int i = 0; i < numRover; ++i) {
        cout << " " << rovers[i];
    }
    cout << " - rover" << endl;
    cout << "                 ";
    for (int i = 0; i < numPeticion; ++i) {
        cout << " " << peticiones[i];
    }
    cout << " - peticion" << endl;
    cout << "        )" << endl;
    
    cout << "        (:init";
    //cout << "                  ";
    for (int i = 0; i < numRover; ++i) {
        int x = rand()%2;
        if (x == 0) {
            int y = rand()%numAsentamiento;
            cout << " (esta " << rovers[i] << " " << asentamientos[y] << ")";
        }
        else {
            int y = rand()%numAlmacene;
            cout << " (esta " << rovers[i] << " " << almacenes[y] << ")";
        }
    }
    cout << endl << endl;
    
    
    cout << "                  ";
    for (int i = 0; i < numRover; ++i) {
        cout << " (= (numPersonal " << rovers[i] << ") 0)";
    }
    cout << endl;
    cout << "                  ";
    for (int i = 0; i < numRover; ++i) {
        cout << " (= (numSuministro " << rovers[i] << ") 0)";
    }
    cout << endl << endl;
    cout << "                  ";
    for (int i = 0; i < numRover; ++i) {
        cout << " (vacio " << rovers[i] << "))";
    }
    cout << endl << endl;
    
    cout << "                  ";
    for (int i = 0; i < numRover; ++i) {
        int combustible = rand()%20+1;
        cout << " (= (combustible " << rovers[i] <<  ") " << combustible << ")";
    }
    cout << endl << endl;
    
    cout << "                  ";
    for (int i = 0; i < numPeticion; ++i) {
        int x = rand()%2;
        if (x == 0) {
            cout << " (peticion-dePersonal " << peticiones[i] << ")";
            ++numPersonal;
        }
        else {
            cout << " (peticion-deSuministro " << peticiones[i] << ")";
            ++numSuministro;
        }
    }
    cout << endl << endl;
    
    cout << "                  ";
    for (int i = 0; i < numAsentamiento; ++i) {
        int num = rand()%numPersonal;
        numPersonal -= num;
        if (num == 0) disponibleAsentamientos.push_back(false);
        else disponibleAsentamientos.push_back(true);
        cout << " (= (disponiblePersonal " << asentamientos[i] << ") " << num << ")";
    }
    cout << endl;
    
    cout << "                  ";
    for (int i = 0; i < numAlmacene; ++i) {
        int num = rand()%numSuministro;
        numSuministro -= num;
        if (num == 0) disponibleAlmancenes.push_back(false);
        else disponibleAlmancenes.push_back(true);
        cout << " (= (disponibleSuministro " << almacenes[i] << ") " << num << ")";
    }
    cout << endl << endl;
    
    
    for (int i = 0; i < numRover; ++i) {
        cout << "                  ";
        cout << " (no-dePersonal " << rovers[i] <<  ")" << " (no-deSuministro " << rovers[i] << ")" << endl;
    }
    cout << endl;
    cout << "                  ";
    for (int i = 0; i < numPeticion; ++i) {
        cout << " (no-hecho " << peticiones[i] << ")";
    }
    cout << endl << endl;
    cout << "                  ";
    for (int i = 0; i < numAsentamiento; ++i) {
        if (disponibleAsentamientos[i]) {
            cout << " (disponible " << asentamientos[i] << ")";
        }
        else cout << " (no-disponible " << asentamientos[i] << ")";
    }
    cout << endl;
    cout << "                  ";
    for (int i = 0; i < numAlmacene; ++i) {
        if (disponibleAlmancenes[i]) {
            cout << " (disponible " << almacenes[i] << ")";
        }
        else cout << " (no-disponible " << almacenes[i] << ")";
    }
    cout << endl << endl;
    cout << "                  ";
    for (int i = 0; i < numPeticion; ++i) {
        int asentamiento = rand()%numAsentamiento;
        cout << " (destinoPeticion " << peticiones[i] << " " << asentamientos[asentamiento] << ")";
    }
    cout << endl << endl;
    
    
    cout << "                   (= (combustibleTotal) 0)" << endl << endl;
    
    cout << "        (:goal (and" << endl;
    cout << "                   (forall (?b - base) (no-disponible ?b) )" << endl;
    cout << "                   (forall (?r - rover) (vacio ?r) )" << endl;
    cout << "               )" << endl;
    cout << "        )" << endl;
    cout << "        (:metric minimize (combustibleTotal) )" << endl;
    cout << ")" << endl;
    
}

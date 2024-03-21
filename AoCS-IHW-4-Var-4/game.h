#ifndef AOCS_IHW_4_VAR_4_GAME_H
#define AOCS_IHW_4_VAR_4_GAME_H

#import <random>
#import <queue>
#include <unistd.h>
#include "utils.h"
#include "pthread.h"
#include "semaphore.h"

using namespace std;

// For simpler use
#define Job pair<unsigned int, unsigned int>

// Swarm of bees, indexed, with given job and result, wrap around pthread_t
struct Swarm {
    unsigned int index{};
    Job job;
    bool result{};
    pthread_t thread{};
};

// utilities for multitasking
pthread_mutex_t mutex;
pthread_cond_t jobs_available;

// Utilities for randomizing
random_device rd;
mt19937 mt(rd());
uniform_int_distribution<unsigned int> dist(0, UINT32_MAX);

// Main static resources for the program
bool **forest;
Swarm *bees;
queue<Job > jobs;
unsigned int M, N, m, n, K;
bool bearFound = false;

void * createJobs(void* params) {
    // create jobs
    vector<Job > random_jobs;
    random_jobs.reserve(M * N);
    for (unsigned int i = 0; i < M; ++i)
        for (unsigned int j = 0; j < N; ++j)
            random_jobs.emplace_back(i + 1, j + 1);

    // create iterator to help
    auto it = random_jobs.begin();

    // after sleeping random time 1 to 10s select random job and push it into task queue
    for (unsigned int i = 0; i < M * N; ++i) {
        if (!bearFound) {
            auto time = dist(mt) % 3 + 1;
            sleep(time);
            auto pos = dist(mt) % random_jobs.size();

            pthread_mutex_lock(&mutex);
            jobs.push(random_jobs.at(pos));
            pthread_mutex_unlock(&mutex);

            it = random_jobs.begin();
            advance(it, pos);
            random_jobs.erase(it);
        }
        pthread_cond_broadcast(&jobs_available);
    }
    return nullptr;
}

// Method for searching through a lot
bool searchLot(unsigned int x, unsigned int y) {
    auto time = dist(mt) % 10 + 1;
    sleep(time);
    forest[x - 1][y - 1] = true;
    return (x == m) && (y == n);
}

// Main task for threads
void *doJobs(void *params) {
    auto time = dist(mt) % 3 + 1;
    sleep(time);
    auto swarm = (Swarm *) params;
    printf("Swarm %d is ready to depart.\n", swarm->index);

    while (!bearFound) {
        pthread_mutex_lock(&mutex);
        while (jobs.empty() && !bearFound)
            pthread_cond_wait(&jobs_available, &mutex);
        if (bearFound) {
            pthread_mutex_unlock(&mutex);
            break;
        }
        swarm->job = jobs.front();
        jobs.pop();
        printf("Swarm %d has received task to look search lot (%d, %d)\n", swarm->index, swarm->job.first,
               swarm->job.second);
        pthread_mutex_unlock(&mutex);

        swarm->result = searchLot(swarm->job.first, swarm->job.second);

        printf("Swarm %d has returned from with result: %s at lot (%d, %d)\n", swarm->index,
               (swarm->result ? "Bear found" : "Bear not found"), swarm->job.first,
               swarm->job.second);
        pthread_mutex_lock(&mutex);
        if (swarm->result)
            bearFound = true;
        pthread_mutex_unlock(&mutex);
    }
    return nullptr;
}

void startGame() {
    // initialize multitasking tools
    pthread_mutex_init(&mutex, nullptr);
    pthread_cond_init(&jobs_available, nullptr);

    // Entering M and N
    string prompt = "forest length and height (in lots)";
    requireInput2(prompt, M, N, 1u, 100u, 1u, 100u);

    // Entering m and n
    prompt = "Vinnie the Pooh's hideout coords";
    requireInput2(prompt, m, n, 1u, M, 1u, N);

    // Entering K
    prompt = "number of bee swarms";
    requireInput(prompt, K, 1u, 50u);

    // initialize forest
    forest = new bool *[M];
    for (unsigned int i = 0; i < M; ++i)
        forest[i] = new bool[N];

    // initialize the hive
    pthread_t hive;
    pthread_create(&hive, nullptr, &createJobs, nullptr);

    bees = new Swarm[K];
    for (unsigned int i = 0; i < K; ++i) {
        bees[i].index = i + 1;
        pthread_create(&bees[i].thread, nullptr, &doJobs, &bees[i]);
    }

    // clearing up
    for (unsigned int i = 0; i < K; ++i)
        pthread_join(bees[i].thread, nullptr);

    for (unsigned int i = 0; i < M; ++i)
        delete[] forest[i];
    delete[] forest;

    bearFound = false;

    pthread_mutex_destroy(&mutex);
    pthread_cond_destroy(&jobs_available);
}

#endif //AOCS_IHW_4_VAR_4_GAME_H
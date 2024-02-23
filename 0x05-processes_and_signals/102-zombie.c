#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

/**
 * zombie - creates a zombie process
 * Return: Always 0 on success
 */

void zombie(void)
{
	pid_t c_pid = fork();

	if (c_pid < 0)
	{
		perror("FAILED!");
		exit(EXIT_FAILURE);
	}
	else if (c_pid > 0)
	{
		printf("Zombie process created, PID: %d\n", getpid());
		exit(EXIT_SUCCESS);
	}
}

int main(void)
{
	int i;

	for (i = 0; i < 5; i++)
	{
		zombie();
	}

	pause();
	return (0);
}


